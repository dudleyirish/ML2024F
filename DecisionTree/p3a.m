%% usage: e = p3a (trainfile, testfile)
%%
%% trainfile - The file path for the file containing training data
%% testfile - The file path for the file containing test data
%% e - error rate from running the training data.
%%
function e = p3a (trainfile, testfile)
  global NextNode Connectivity NodeName NodeValue NodeLabel AttrValues
  attr_names = {'age'; 'job'; 'marital'; 'education';'default'; 'balance';
		'housing'; 'loan'; 'contact'; 'day'; 'month'; 'duration';
		'campaign'; 'pdays'; 'previous'; 'poutcome'; 'y'};
  attr_values = {{'numeric'};
		 {"admin.","unknown","unemployed","management","housemaid", ...
		  "entrepreneur","student","blue-collar","self-employed", ...
		  "retired","technician","services"};
		 {"married", "divorced", "single"};
		 {"unknown","secondary","primary","tertiary"};
		 {"yes","no"};
		 {'numeric'};
		 {"yes","no"};
		 {"yes","no"};
		 {"unknown","telephone","cellular"};
		 {'numeric'};
		 {'apr', 'aug', 'dec', 'feb', 'jan', 'jul', 'jun', 'mar', ...
		  'may', 'nov', 'oct', 'sep'};
		 {'numeric'};
		 {'numeric'};
		 {'numeric'};
		 {'numeric'};
		 {"unknown","other","failure","success"}
		};
  thresholds = [38,    %% age
		 0,     %% job
		 0,     %% marital
		 0,     %% education
		 0,     %% default
		 452.5, %% balance
		 0,     %% housing
		 0,     %% loan
		 0,     %% contact
		 16,    %% day
		 0,     %% month
		 180,   %% duration
		 2,     %% compaign
		 189,   %% pdays
		 0,     %% previous
		 0,     %% poutcome
		 0];    %% y
		 
  S = p3a_CleanData(trainfile, "banktrain.mat", thresholds);
  T = p3a_CleanData(testfile, "banktest.mat", thresholds);
  F = ones(rows(S), 1);

  printf("Learn different depth trees from 1 to 16 with information gain.\n");
  delete("bankig*.m");
  tic()
  for depth = 1:16
    ID3(S, F, depth, attr_names, attr_values, columns(S), @FindSplitIG);
    name = sprintf("bankig%d", depth);
    CreateClassifier(name, Connectivity, NodeName, NodeLabel, NodeValue, ...
		     attr_names);
  end
  printf("Learning trees took %d seconds.\n", toc());
  tic()
  ig_error_rates = p3a_RunTests(S, T, 'bankig');
  printf("Running tests took %d seconds.\n", toc());

  e = ig_error_rates;
endfunction
