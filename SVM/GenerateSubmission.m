%% usage: GenerateSubmission (Ids, Labels, output_file_name)
%%
%%
function GenerateSubmission (Ids, Labels, filename)
  fid = fopen(filename, "w");
  if (fid == -1)
    error("Could not open output file");
  else
    fprintf(fid, "ID,Prediction\n")

    for r = 1:rows(Ids)
      fprintf(fid, "%d,%d\n", Ids(r), Labels(r));
    end
  end
  fclose(fid);
end
