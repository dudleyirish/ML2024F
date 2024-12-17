%% usage: submit (T, r)
%%
%%
function submit (T, r)
  Train = load("../prep/train.mat").S;
  Test = load("../prep/test.mat").S;

  %% Prepare the data
  %% Last column of S is the labels.
  m = rows(Train);
  X = Train(:,1:end-1);
  X = [X, ones(m, 1)]';
  Y = Train(:,end);

  printf("Train averaged perceptron.\n");
  tic();
  [w, e, u] = TrainAveragedPerceptron(X, Y, T, r);
  printf("Training took %d seconds\n", toc());
  printf("w =[%f", w(1));
  printf(", %f", w(2:end));
  printf("]\n");
  printf("Training error count = %d\n", e);

  tic()
  GenerateSubmission(w, Test, "Perceptron.csv");
  printf("Generating submission took %d seconds.\n", toc());
end
