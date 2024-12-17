%% usage: gi = GI (A)
%%
%% A array that Gini Index is computed for
function gi = GI (A)
  if isempty(A)
    gi = 0;
  else
    tot = rows(A);
    u = unique(A);
    N = rows(u);
    s = 0;
    for k = 1:N
      p = sum(strcmp(A, u(k)))/tot;
      s = s + p^2;
    end
    gi = 1 - s;
  end
endfunction
