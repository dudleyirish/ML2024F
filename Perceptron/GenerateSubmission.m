%% usage: GenerateSubmission (S, output_file_name)
%%
%%
function GenerateSubmission (w, S, filename)
  fid = fopen(filename, "w");
  if (fid == -1)
    error("Could not open output file");
  else
    fprintf(fid, "ID,Prediction\n")

    for r = 1:rows(S)
      p = (sign(w'*[S(r,1:end-1), 1]') + 1) / 2;
      fprintf(fid, "%d,%d\n", S(r,end), p);
    end
  end
  fclose(fid);
end
