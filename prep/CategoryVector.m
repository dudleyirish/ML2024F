%% usage: C = CategoryVector (m, k)
%%
%%
function C = CategoryVector (m, k)
  C = zeros(m.Count, 1);
  C(m(k)) = 1;
endfunction
