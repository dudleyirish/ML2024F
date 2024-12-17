%% usage: e = ComputeTrainingError (S, depth, prefix)
%%
%%
function e = ComputeTrainingError (S, depth, prefix)
  fh = str2func(sprintf("%s%02d", prefix, depth));
  training_err = 0;
  for r = 1:rows(S)
    l = fh(S(r, :));
    if S(r, end) == l
      training_err = training_err + 1;
    end
  end
  e = training_err/rows(S);
end
