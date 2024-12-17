%% usage: S = SVM_CleanData (filepath, ofile, train_flag)
%%
%% filepath -- The input data file in csv format
%% ofile -- the output file write in octave mat format
%% train_flag -- 1 if training data, 0 if test data
%%
%% This prepares the data to train a SVM.
%%
function S = SVM_CleanData (filepath, ofile, train_flag)
  S = [];
  if exist(ofile, "file")
    printf("Output file already exists, reading it.\n");
    tic()
    input = load(ofile);
    printf("Reading Octave file took %f secconds\n", toc());
    S = input.S;
  else
    printf("Output file does not exists, cleaning data file\n");
    tic()

    %% Setup to convert to numbers
    workclass = containers.Map({"?", "Private", "Self-emp-not-inc", ...
				"Self-emp-inc", "Federal-gov", ...
				"Local-gov", "State-gov", "Without-pay", ...
				"Never-worked"}, 1:9);
    education = containers.Map({"Bachelors", "Some-college", "11th", ...
				"HS-grad", "Prof-school", "Assoc-acdm", ...
				"Assoc-voc", "9th", "7th-8th", "12th", ...
				"Masters", "1st-4th", "10th", "Doctorate", ...
				"5th-6th", "Preschool"}, 1:16);
    marital = containers.Map({"Married-civ-spouse", "Divorced", ...
			      "Never-married", "Separated", "Widowed", ...
			      "Married-spouse-absent", ...
			      "Married-AF-spouse"}, 1:7);
    occupation = containers.Map({"?", "Tech-support", "Craft-repair", ...
				 "Other-service", "Sales", ...
				 "Exec-managerial", "Prof-specialty", ...
				 "Handlers-cleaners", "Machine-op-inspct", ...
				 "Adm-clerical", "Farming-fishing", ...
				 "Transport-moving", "Priv-house-serv", ...
				 "Protective-serv", "Armed-Forces"}, 1:15);
    relationship = containers.Map({"Wife", "Own-child", "Husband", ...
				   "Not-in-family", "Other-relative", ...
				   "Unmarried"}, 1:6);
    race = containers.Map({"White", "Asian-Pac-Islander", ...
			   "Amer-Indian-Eskimo", "Other", "Black"}, 1:5);
    sex = containers.Map({"Female", "Male"}, 1:2);
    native_country = containers.Map({"?", "United-States", "Cambodia", ...
				     "England", "Puerto-Rico", "Canada", ...
				     "Germany", ...
				     "Outlying-US(Guam-USVI-etc)", ...
				     "India", "Japan", "Greece", "South", ...
				     "China", "Cuba", "Iran", "Honduras", ...
				     "Philippines", "Italy", "Poland", ...
				     "Jamaica", "Vietnam", "Mexico", ...
				     "Portugal", "Ireland", "France", ...
				     "Dominican-Republic", "Laos", ...
				     "Ecuador", "Taiwan", "Haiti", ...
				     "Columbia", "Hungary", "Guatemala", ...
				     "Nicaragua", "Scotland", "Thailand", ...
				     "Yugoslavia", "El-Salvador", ...
				     "Trinadad&Tobago", "Peru", "Hong", ...
				     "Holand-Netherlands"}, 1:42);
    %% compute the number of output columns
    cols_out = 109;
    printf("Columns in the output: %d\n", cols_out);

    %% Read the data file:
    row = 1;
    fid = fopen(filepath, 'r');
    fgetl(fid); %% Skip headers.

    while true
      txt = fgetl(fid);
      if txt == -1
	break;
      end
      if train_flag
	cstr = strsplit(txt, ',');
      else
	%% In the test data, the first column is the label.  We move this to
	%% the last column.
	cstr = strsplit(txt, ',')([2:end, 1]);
      end
      cnum = zeros(1,cols_out);
      %% Convert strings to numbers and numeric to bools
      cnum(1) = str2num(cstr{1}); %% age
      cnum(2:10) = CategoryVector(workclass, cstr{2}); %% workclass
      cnum(11) = str2num(cstr{3}); %% fnlwgt
      cnum(12:27) = CategoryVector(education, cstr{4}); %% education
      cnum(28) = str2num(cstr{5}); %% education.num
      cnum(29:35) = CategoryVector(marital, cstr{6}); %% marital.status
      cnum(36:50) = CategoryVector(occupation, cstr{7}); %% occupation
      cnum(51:56) = CategoryVector(relationship, cstr{8}); %% relationship
      cnum(57:61) = CategoryVector(race, cstr{9}); %% race
      cnum(62:63) = CategoryVector(sex, cstr{10}); %% sex
      cnum(64) = str2num(cstr{11}); %% capital.gain
      cnum(65) = str2num(cstr{12}); %% capital.loss
      cnum(66) = str2num(cstr{13}); %% hours.per.week
      cnum(67:108) = CategoryVector(native_country, cstr{14}); %% native.country
      if train_flag
	%% In the training data the last column is the label, "income>50k".
	cnum(109) = str2num(cstr{15}) * 2 - 1; %% income>50K
      else
	%% In the test data, the id has been moved from the first column to
	%% the last.
	cnum(109) = str2num(cstr{15});
      end

      S = [S; cnum];
    end
    fclose(fid);
    printf("Reading CSV file took %f secconds\n", toc());

    tic()
    save("-binary", ofile, "S");
    printf("Writing Octave file took %f secconds\n", toc());
  end
end

function C = CategoryVector (m, k)
  C = zeros(m.Count, 1);
  C(m(k)) = 1;
endfunction
