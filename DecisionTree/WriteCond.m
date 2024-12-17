%% usage: WriteCond (C, N, L, V)
%%
%% C connectivity matrix
%% N node names
%% L node labels
%% V node values
%%
function WriteCond (C, N, L, V)
  WriteCond1('', 1, C, N, L, V);
  printf("\n");
end

function WriteCond1 (expr, node, C, N, L, V)
  persistent needs_and = 0;
  %%printf("Entering WriteCond1: expr = %s, value = %s\n", expr, char(V(node)));
  children = [];
  if node <= rows(C)
    children = find(C(node,:));
  end
  if needs_and
    printf(" AND\n");
    needs_and = 0;
  end
  if isempty(children)
    printf("((%s) Label = '%s')", expr, L{node})
    needs_and = 1;
  else
    if !isempty(expr)
      expr = cstrcat(expr, " AND ");
    end
    for child = children
      WriteCond1(cstrcat(expr, sprintf("%s = '%s'", N{node}, V{child})), ...
		 child, C, N, L, V);
    end
  end
end
