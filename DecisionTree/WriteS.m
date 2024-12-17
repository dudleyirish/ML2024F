%% usage: WriteS (S)
%%
%% S is the examples or training data to be written
%%
function WriteS(S, attr_names)
  col_width = max(cellfun("length", attr_names)) + 2;
  printf("      ");
  for r = 1:rows(attr_names)
    printf("%-*s", col_width, attr_names{r});
  end
  fprintf("\nS = [")
  for r = 1:rows(S)
    if r > 1
      printf("     ");
    end
    printf("[");
    for c = 1:columns(S)
      printf("%-*s", col_width, S{r, c});
    end
    printf("]");
    if r < rows(S)
      printf(",\n");
    end
  end
  printf("]\n");
end
