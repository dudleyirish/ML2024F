%% usage: node = FindSplitME (S, attr_names, attr_values)
%%
%%  
%%  S - the sample data
%%  attr_names - string labels for the attributes
%%  attr_values - possible values for the attributes
%%
%%  Return value is the attribute on which to split
%%
function attr = FindSplitME (S, attr_names, attr_values)
  ME_S = ME(S(:,end));
  %%printf("\n    Entering FindSplit ME: ME(S) = %d\n", ME_S);
  gains = [];
  
  for attr = 1:columns(S)-1
    %%printf("    Information gain: %s\n", attr_names{attr});
    values = attr_values{attr};
    sum = 0;
    for idx = 1:columns(values)
      Sv = S(find(strcmp(S(:, attr), values(idx))), end);
      ME_Sv = ME(Sv);
      if isempty(Sv)
	%%printf("        %s = %s: |Sv| = 0, |S| = %d, ME(Sv) = 0\n", ...
	%%       attr_names{attr}, values{idx}, rows(S));
      else
	sum = sum + rows(Sv)/rows(S) * ME_Sv;
	%%printf("        %s = %s: |Sv| = %d, |S| = %d, ME(Sv) = %d\n", ...
	%%       attr_names{attr}, values{idx}, rows(Sv), rows(S), ME_Sv);
      end
    end
    gains(attr) = ME_S - sum;
    %%printf("        Information gain: %d\n", gains(attr));
  end
  [maxgain, attr] = max(gains);
end
