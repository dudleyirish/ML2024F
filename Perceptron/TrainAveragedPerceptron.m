%% usage: [a, e, u] = TrainAveragedPerceptron (X, Y, T, r)
%%
%% Trains an averaged perceptron.
%%
%% X -- augmented training data, transposed so each example is a column
%% Y -- labels
%% T -- Number of epochs.
%% r -- training rate
%%
%% returns:
%% w - a vector of augmented weight vectors
%% e - the training error.
%% u - number of updates;
%%
function [a, e, u] = TrainAveragedPerceptron (X, Y, T, r)
  %% quiet mode
  quiet = 1;
  %% Prepare the data
  %% X is transposed so that each example is a column vector
  m = columns(X);
  d = rows(X);

  w = zeros(d,1);  %% initialize the Augmented weights
  a = w;
  updates = 0;
  for epoch = 1:T
    if !quiet
      if epoch > 1
	printf("\n\n");
      end
      printf("Epoch %d:\n", epoch);
    end
    %% shuffle the training data
    V = randperm(columns(X));
    S = X(:, V);
    Ys = Y(V,:);
    for i=1:m
      ## if !quiet
      ## 	printf("    Ys(%d)*w'*S(:,%d) = %f\n", i, i, Ys(i)*w'*S(:,i))
      ## end
      if Ys(i)*w'*S(:,i) <= 0
	update = r*(Ys(i)*S(:,i));
	w = w + update ;
	updates = updates + 1;

	if !quiet
	  printf("      S(:,%d) = [%f", i, S(1,i));
	  printf(", %f", S(2:end,i));
	  printf("]\n");
	  printf("      Update = r*(%d)*S(i) = [%f", Ys(i), update(1));
	  printf(", %f", update(2:end));
	  printf("]\n");
	  printf("      w = [%f", w(1));
	  printf(", %f", w(2:end));
	  printf("], ErrorCount = %d\n\n", ErrorCount(w, S, Ys));
	end
      end
      a = a + w;
    end

    e = ErrorCount(w, S, Ys);
  
    if !quiet
      printf("  updates = %d, ||w||: %f, error count = %d, error rate = (%f)\n", ...
	     updates, sqrt(sumsq(w)), e, e/m);
    end
    if e == 0
      break;
    end
  end
  e = e;
  u = updates;
end
