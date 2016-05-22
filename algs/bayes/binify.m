function [dataframe, edges] = binify(dataframe)
  [~, n] = size(dataframe);
  edges = cell(n, 1);

  for i = 1 : n
		[~, edges{i}] = histcounts(dataframe(:, i));
		dataframe(:, i) = discretize(dataframe(:, i), edges{i});
	end
end
