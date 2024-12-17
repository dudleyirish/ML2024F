%% 
%% usage: e = practice4a (trainfile, testfile)
%%
%% trainfile - The file path for the file containing training data
%% testfile - The file path for the file containing test data
%% outputfile - A text file that progress and debug information is writtent to.
%%
%% J - cost function value from each iteration
%%
function J = practice4a (trainfile, testfile)
  names = {'Cement'; 'Slag'; 'Fly ash'; 'Water'; 'SP'; 'Coarse Aggr.'; 'Fine Aggr.'};

  %% "~/CS/CS6350/concrete/train.csv"
  S = csvread(trainfile);
  Train = S(:,1:7);
  train_y = S(:, end);
  %% "~/CS/CS6350/concrete/test.csv"
  S = csvread(testfile);
  Test = S(:,1:7);
  test_y = S(:, end);
  
  x = [Train, ones(53,1)]';
  w = zeros(8,1);
  [J, w, G] = GradientDescent(w, x, train_y, .0125);

  %% Compute cost function on test data
  x = [Test, ones(rows(Test),1)]';
  test_cost = ComputeCost(w, x, test_y);
  printf("Test cost is %.4f\n", test_cost);

  plot(1:columns(J), J);
  title("Cost at each iteration, learning rate $= 0.0125");
  print("-deps", "practice4a.eps");
end
