%% usage: node = FindSplitIG (S, attr_names, attr_values)
%%
%%  
%%  S - the sample data
%%  attr_names - string labels for the attributes
%%
%%  Return value is the attribute on which to split
%%
function attr = FindSplitIG (S, attr_names, attr_counts)
  EntropyS = H(S(:,end));
  %%printf("\n    Entering FindSplit: EntropyS = %d, %d\n", EntropyS, columns(S));
  gains = [];
  
  for attr = 1:columns(S)-1
    %%printf("    Information gain: %s\n", attr_names{attr});
    value_count = attr_counts(attr);
    if value_count == -1
      values = [-1, 1];
    elseif value_count == 1
      values = [0, 1];
    else
      values = 1:value_count;
    end
    sum = 0;
    for idx = 1:columns(values)
      v = values(idx);
      Sv = S(find(S(:, attr) == v), end);

      if isempty(Sv)
	%%printf("        %s = %d: 0 of %d examples\n", ...
	       %%attr_names{attr}, v, rows(S));
	%%printf("            p = 0  n = 0  Hs = 0\n");
      else
	[EntropySv, ir] = H(Sv);
	sum = sum + rows(Sv)/rows(S) * EntropySv;
	%%printf("        %s = %d: %d of %d examples\n", ...
	       %%attr_names{attr}, v, rows(Sv), rows(S));
	%%printf("            p = %s  n = %s  Hs = %d\n", ...
	       %%strtrim(rats(ir(1))), strtrim(rats(ir(2))), EntropySv);
      end
    end
    gains(attr) = EntropyS - sum;
    %%printf("        Information gain: %d\n", gains(attr));
  end
  [maxgain, attr] = max(gains);
end
