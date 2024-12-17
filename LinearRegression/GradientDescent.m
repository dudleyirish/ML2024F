%% usage: [[J, w]] = GradientDescent (w, x, y, r)
%%
%%
function [J, w, G] = GradientDescent (w, x, y, r)
  m = columns(x);
  for t=1:10
    J = ComputeCost(w, x, y);
    G = ComputeGradient(w, x, y);
    w = w + r*G';
    printf("cost:%.4f, gradient:[%.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f]\n", J, G);
    printf("weights: [%.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f, %.4f]\n", w);
    printf("sqrt(sumsq(G)) = %0.4f\n", sqrt(sumsq(G)));
  end
end
