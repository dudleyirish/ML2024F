%% usage: S = Project_CleanData (filepath, ofile, train_flag)
%%
%% filepath -- The input data file in csv format
%% ofile -- the output file write in octave mat format
%% train_flag -- 1 if training data, 0 if test data
%%
function S = Project_CleanData (filepath, ofile, train_flag)
  global outf
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
	cstr = strsplit(txt, ',')([2:end, 1]);
      end
      cnum = zeros(1,rows(cstr));
      %% Convert strings to numbers and numeric to bools
      cnum(1) = str2num(cstr{1}) > 37; %% age
      cnum(2) = workclass(cstr{2}); %% workclass
      cnum(3) = str2num(cstr{3}) > 177299.50; %% fnlwgt
      cnum(4) = education(cstr{4}); %% education
      cnum(5) = str2num(cstr{5}); %% education.num
      cnum(6) = marital(cstr{6}); %% marital.status
      cnum(7) = occupation(cstr{7}); %% occupation
      cnum(8) = relationship(cstr{8}); %% relationship
      cnum(9) = race(cstr{9}); %% race
      cnum(10) = sex(cstr{10}); %% sex
      cnum(11) = str2num(cstr{11}) > 0; %% capital.gain
      cnum(12) = str2num(cstr{12}) > 0; %% capital.loss
      cnum(13) = str2num(cstr{13}) > 40; %% hours.per.week
      cnum(14) = native_country(cstr{14}); %% native.country
      if train_flag
	cnum(15) = str2num(cstr{15}) * 2 - 1; %% income>50K or ident
      else
	cnum(15) = str2num(cstr{15});
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

function out = yesno2plusminus(in)
  out = -1;
  if strcmp(in, 'yes')
    out = 1;
  end
end
