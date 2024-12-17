%% usage: [[J, w]] = StochasticGradientDescent (w, x, y, r)
%%
%%
function [J, w, G] = StochasticGradientDescent (w, x, y, r, T)
  for t=1:T
    for i=1:columns(x)
      for j=1:rows(w)
	G(j,1) = (y(i) - w'*x(:,i))*x(j,i);
      end

      w = w + r*G;

      if sqrt(sumsq(G)) < 0.01
	break;
      end
    end

    J(t) = ComputeCost(w, x, y);
    if sqrt(sumsq(G)) < 0.001
      break;
    end
  end
end
