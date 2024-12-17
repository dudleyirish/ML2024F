%% usage: e = p3a (depth)
%%
%% depth -- max tree depth, -1 is unlimited
%%
%% e - error rate from running the training data.
%%
%% This script is hardcode to read input from "train.mat" and "test.mat"
%%
function e = submit (depth)
  global NextNode Connectivity NodeName NodeValue NodeLabel AttrValues ...
	 MaxLevel
  attr_names = {"age"; "workclass"; "fnlwgt"; "education"; "education.num",
		"marital.status"; "occupation"; "relationship"; "race",
		"sex"; "capital.gain"; "capital.loss"; "hours.per.week",
		"native.country"; "income>50K"};
  attr_values = [1, 9, 1, 16, 16, 7, 15, 6, 5, 2, 1, 1, 1, 42, -1];

  Train = load("../prep/train.mat").S;
  Test = load("../prep/test.mat").S;
  F = ones(rows(Train), 1);

  for depth = 6:16
    printf("Learn decision tree of depth %d with information gain.\n", depth);
    tic()
    ID3(Train, F, depth, attr_names, attr_values, columns(Train), @FindSplitIG);
    name = sprintf("income%02d", depth);
    CreateClassifier(name, Connectivity, NodeName, NodeLabel, NodeValue, ...
		     attr_names);
    printf("Learning trees took %d seconds. MaxLevel = %d\n", toc(), MaxLevel);

    tic()
    e = ComputeTrainingError(Train, depth, "income");
    printf("Computing training error (%d) took %d seconds.\n", e, toc());

    tic()
    GenerateSubmission(Test, depth, 'income');
    printf("Generating submission took %d seconds.\n", toc());
  end
end
