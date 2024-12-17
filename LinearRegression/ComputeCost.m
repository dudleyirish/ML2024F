%% usage: cost = ComputeCost (w, x, y)
%%
%%
function cost = ComputeCost (w, x, y)
  cost = 0;
  for i=1:columns(x)
    cost = cost + (y(i) - w'*x(:,i))^2;
  end
end
