##
## Compute majority error of sample
##
function me = ME(S)
  m = cellmode(S);
  count = rows(find(strcmp(S, m)));
  t = rows(S);
  me = (t - count)/t;
end
