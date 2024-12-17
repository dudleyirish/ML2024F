%% usage: e = ErrorCount (w, X, Y)
%%
%%
function e = ErrorCount (w, X, Y)
  e = 0;
  for i=1:rows(Y)
    %%printf("w'*X(:,%d)) = %f, Y(%d) = %f\n", i, w'*X(:,i), i, Y(i));
    if sign(w'*X(:,i)) != Y(i)
      e = e + 1;
    end
  end
endfunction
