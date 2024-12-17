%% usage: GenerateSubmission (S, depth, prefix)
%%
%%
function GenerateSubmission (S, depth, prefix)
  filename = sprintf("%s_submision.csv", prefix);
  fid = fopen(filename, "w");
  if (fid == -1)
    error("Could not open output file");
  else
    fprintf(fid, "ID,Prediction\n")

    fh = str2func(sprintf("%s%02d", prefix, depth));
    for r = 1:rows(S)
      l = fh(S(r, :));
      fprintf(fid, "%d,%d\n", S(r,end), l);
    end
  end
end
