%% usage: submit (C, gamma)
%%
%%
close all; clear all;
%%function submit (C, gamma)
  Train = load("../prep/svmtrain.mat").S;
  Test = load("../prep/svmtest.mat").S;

  %% Prepare the data
  %% Last column of S is the labels.
  d = columns(Train) - 1;
  m = rows(Train);
  Xin = Train(:,1:end-1);
  Yin = Train(:,end);
  testXin = Test(:,1:end-1);
  testYin = Test(:,end);

  scale_min = min(min(Xin), min(testXin));
  scale_max = max(max(Xin), max(testXin));

  Xscaled = (Xin - scale_min) .* (1./(scale_max-scale_min));
  testXscaled = (testXin - scale_min) .* (1./(scale_max-scale_min));

  %%printf("Grid search.\n");
  %%tic();
  %%CRange = 2.^[-5:2:15];
  %%gamma_range = 2.^[-15:2:3];
  %%[C, gamma, A] = grid (Xin, Yin, 5, CRange, gamma_range);
  %%save "grid_poly.mat" CRange gamma_range C gamma A;
  %%printf("Grid search took %d seconds\n", toc());
  %% Debug
  C = 2;
  gamma = 3.0518e-05;

  options = sprintf("-q -t 2 -c %f -g %f", C, gamma);
  model = svmtrain(Yin, Xscaled, options);

  printf("Training took %d seconds\n", toc());
  [label, training_accuracy, dec] = svmpredict(Yin, Xscaled, model, '-q');
  printf("Training error rate: %f\n", 100 - training_accuracy(1));

  tic();
  [label, training_accuracy, dec] = ...
    svmpredict(testYin, testXscaled, model, '-q');
  GenerateSubmission(testYin, label, "svm_submission.csv");
  printf("Generating submission took %d seconds.\n", toc());
%%end
