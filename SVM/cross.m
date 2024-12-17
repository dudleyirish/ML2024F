%% usage: a = cross (Xin, Yin, v, C, gamma)
%%
%% Performs a cross validation grid search
%%
function a = cross (Xin, Yin, v, C, gamma)
  printf("Train SVM with cross-validation.\n");
  tic();
  options = sprintf("-t 2 -v %d -c %f -g %f", v, C, gamma);
  a = svmtrain(Yin, Xin, options);
  printf("Training took %d seconds, cross validation accuracy %f\n", ...
	 toc(), a);
end
