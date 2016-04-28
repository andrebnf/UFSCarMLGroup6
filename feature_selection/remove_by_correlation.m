function df = remove_by_correlation(dataframe, labels, percentile)
  df = dataframe;

  % Calcula correlacoes
  correlations = corr(df, labels);

  % Remove todos os valores NaN
  correlations(isnan(correlations)) = [];

  % Ordena as correlacoes
  [correlations, indexes] = sort(correlations, 'ascend');

  limit = floor(length(correlations) * percentile);

  df = df(:, indexes(1 : limit));
