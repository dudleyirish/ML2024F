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
