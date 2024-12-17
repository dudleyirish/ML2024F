%% usage: fh = CreateClassifier (C, N, L, V)
%%
%% C connectivity matrix
%% N node names
%% L node labels
%% V node values
%%
%% Returns:
%% fh a function handle to a classification function.
function fh = CreateClassifier (name, C, N, L, V, A)
  filename = strcat(name, ".m");
  fid = fopen(filename, "w");
  if (fid == -1)
    error("Could not open output file");
  else
    fprintf(fid, "function c = %s(a)\n", name)
    CreateClassifier1(fid, '', 1, C, N, L, V, A);
    fprintf(fid, "  end\n");
    fprintf(fid, "endfunction\n");
    fclose(fid);
  end
endfunction

function fh = CreateClassifier1 (fid, expr, node, C, N, L, V, A)
  persistent needs_if = 1;
  persistent needs_elseif = 0;
  persistent needs_and = 0;
  if node == 1
    needs_if = 1;
    needs_elseif = 0;
    needs_and = 0;
  end

  %%printf("Entering CreateClassifier1: %d, needs_and %d\n", node, needs_and);
  children = [];
  if node <= rows(C)
    children = find(C(node,:));
  end
  if isempty(children)
    if needs_if
      fprintf(fid, "  if %s\n", expr);
      needs_if = 0;
    else
      fprintf(fid, "  elseif %s\n", expr);
    end
    fprintf(fid, "    c = %d;\n", L{node});
    needs_and = 0;
  else
    for child = children
      if needs_and
	expr = cstrcat(expr, " && ");
      end
      needs_and = 1;
      attr = find(strcmp(A, N{node}));
      CreateClassifier1(fid, ...
			cstrcat(expr, sprintf("a(%d) == %d", attr, V{child})),
			child, C, N, L, V, A);
    end
  end
end

