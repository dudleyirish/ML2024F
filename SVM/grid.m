%% usage: [C, gamma, A] = grid (Xin, Yin, v, CRange, gamma_range)
%%
%% Performs a grid search and returns the C and gamma that generates a model
%% with the highest accuracy.
function [C, gamma, A] = grid (Xin, Yin, v, CRange, gamma_range)
  printf("Starting Grid Search:\n");

  max_C = 0;
  max_gamma = 0;
  max_accuracy = 0;
  RowIdx = 1;
  A = zeros(length(CRange), length(gamma_range));
  for C = CRange
    ColumnIdx = 1;
    for gamma = gamma_range
      options = sprintf("-q -t 3 -v %d -c %f -g %f", v, C, gamma);
      a = svmtrain(Yin, Xin, options);
      printf("\n\nTraining took %d seconds, cross validation accuracy %f\n", ...
	     toc(), a);
      printf("C = %f, gamma = %f\n\n", C, gamma);
      A(RowIdx, ColumnIdx) = a;

      if a > max_accuracy
	max_C = C;
	max_gamma = gamma;
	max_accuracy = a;
      end
      ColumnIdx = ColumnIdx + 1;
    end
    RowIdx = RowIdx + 1;
  end
  C = max_C;
  gamma = max_gamma;
end
