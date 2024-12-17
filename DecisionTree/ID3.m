%% usage: node = ID3 (S, attr_names, label, value)
%%
%%
function node = ID3 (S, F, level, attr_names, attr_counts, label, splitter)
  global NextNode Connectivity NodeName NodeValue NodeLabel MaxLevel
  if ! is_function_handle(splitter)
    error("Parameter splitter must be a function handle");
  end

  NextNode = 1;
  Connectivity = [];
  NodeName = {};
  NodeValue = {};
  NodeLabel = {};
  MaxLevel = level;
  node = ID3_r (S, F, level, attr_names, attr_counts, label, '_', splitter);
end;

function node = ID3_r (S, F, level, attr_names, attr_counts, label, value, splitter)
  global NextNode Connectivity NodeName NodeValue NodeLabel AttrValues ...
	 MaxLevel
  %%
  if ! is_function_handle(splitter)
    error("Parameter splitter must be a function handle");
  end

  %%printf("Entering ID3: level = %d\n", level);
  if level < -MaxLevel
    MaxLevel = -level;
  end

  %% Allocate a root/leaf node
  node = AllocNode();
  if level == 0
    %%printf("Level limit reached, return leaf node.\n");
    NodeName{node} = 'leaf';
    %% attributes is empty, label is most common value (mode).
    NodeLabel(node) = mode(S(:,end));
    NodeValue(node) = value;    
  %% If all examples have the same label
  elseif all(strcmp(S(:, label), S(1, label)))
    %% return a leaf node
    %%printf("All labels the same, return leaf node.\n");
    NodeName{node} = 'leaf';
    %% If attributes is not empty
    if (columns(S) > 1)
      NodeLabel(node) = S{1, label};
    else %% attributes is empty, label is most common value (mode).
      NodeLabel(node) = mode(S(:,end));
    end 
    NodeValue(node) = value;
  elseif columns(S) == 1
    %% Out of columns, create a leaf node with most common value
    %%printf("Out of columns, return leaf node.\n");
    NodeName{node} = 'leaf';
    NodeLabel(node) = mode(S(:,end));
    NodeValue(node) = value;
  else
    %% Create root node,
    %%printf("Create a root node: %d\n", node);
    split_attr = splitter(S, attr_names, attr_counts);
    %%printf("    split_attr = %d\n", split_attr);
    split_name = strtrim(attr_names{split_attr});
    NodeName{node} = split_name;
    NodeValue(node) = value;
    %%printf("Split attr is %s\n", split_name);
    value_count = attr_counts(split_attr);
    if value_count == -1
      values = [-1, 1];
    elseif value_count == 1
      values = [0, 1];
    else
      values = 1:value_count;
    end
    
    for idx = 1:columns(values)
      value = values(idx);
      matches = find(S(:, split_attr) == value);

      %% if Sv is empty
      if numel(matches) == 0
	m = mode(S(:,end));
	%%printf("Sv is empty, return leafnode, v = %d\n", m);
	leafnode = AllocNode('Leaf', m, value);
	Connectivity(node, leafnode) = 1;
      else
	%%printf("Recur on Sv, attribute value = %d\n", value);
	Sv = S(matches, [1:split_attr-1,split_attr+1:end]);
	newnode = ID3_r(Sv, ...
			F, ...
			level - 1, ...
			attr_names([1:split_attr-1,split_attr+1:end],:), ...
			attr_counts([1:split_attr-1,split_attr+1:end]), ...
			columns(Sv), ...
			values(idx), ...
			splitter);
	Connectivity(node, newnode) = 1;
      end
    end
  end
  %%printf("Leaving ID3\n");
end

function node = AllocNode(name = 'UNKNOWN', label = '_', value='_')
  global NextNode  Connectivity NodeName NodeValue NodeLabel AttrValues
  node = NextNode;
  NextNode = NextNode + 1;
  NodeName{node} = name;
  NodeLabel(node) = label;
  NodeValue(node) = value;
end
