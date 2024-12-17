%% usage: G = ComputeGradient (w, x, y)
%%
%%
function G = ComputeGradient (w, x, y)
  for j=1:rows(w)
    G(j, 1) = 0;
    for i=1:columns(x)
      G(j, 1) = G(j, 1) + (y(i) - w'*x(:,i))*x(j,i);
    end
    G(j, 1) = -G(j, 1);
  end
end
