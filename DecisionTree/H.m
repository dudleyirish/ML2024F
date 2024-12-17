##
## Compute entropy of an array of values.
##
function [h, ir] = H(A)
  if isempty(A)
    h = 0; ir = [0];
  else
    tot = rows(A);
    ir = [0, 0];
    u = unique(A);
    N = rows(u);
    s = 0;
    for k = 1:N
      p = sum(A == u(k))/tot;
      s = s + -p*log2(p);
      ir(k) = p;
    end
    h = s;
  end
end
