%% usage: WriteTree (C, L, V)
%%
%% C connectivity matrix
%% L node labels
%% V node values
%%
function WriteTree (C, N, L, V)
  WriteTree1('', 1, C, N, L, V);
end

function WriteTree1 (indent, node, C, N, L, V)
  printf("%sNode %s(%d)", indent, N{node}, node);
  if strcmp(V{node}, '_') == 0
    printf(", Value=%s", V{node});
  end
  if strcmp(L{node}, '_') == 0
    printf(", Label=%s", L{node});
  end
  if node <= rows(C) && !isempty(find(C(node, :)))
    printf(" connects to: [")
    printf("%d, ",find(C(node,:)));
    printf("]");
  end
  printf("\n");
  if node <= rows(C)
    for child = find(C(node,:));
      WriteTree1(cstrcat(indent, '    '), child, C, N, L, V);
    end
  end
end
