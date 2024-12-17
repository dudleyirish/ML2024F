%% usage: E = p3a_RunTests (S, T)
%%
%%
function E = p3a_RunTests (S, T, pref)
  E = [];
  for depth = 1:16
    fh = str2func(sprintf("%s%d", pref, depth));
    training_err = 0;
    for r = 1:rows(S)
      l = fh(S(r, :));
      if strcmp(S{r, 7}, l) == 0
	training_err = training_err + 1;
      end
    end
    test_err = 0;
    for r = 1:rows(T)
      l = fh(S(r, :));
      if strcmp(S{r, 7}, l) == 0
	test_err = test_err + 1;
      end
    end
    E(depth, :) = [training_err/rows(S), test_err/rows(T)];
  end
endfunction
