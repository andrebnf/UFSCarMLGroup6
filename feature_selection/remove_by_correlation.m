function [df, ids] = remove_by_correlation(dataframe, labels, percentile)
  df = dataframe;

  % Calcula correlacoes
  correlations = corr(df, labels);

  % Remove todos os valores NaN
  correlations(isnan(correlations)) = [];

  % Ordena as correlacoes
  [correlations, ids] = sort(correlations, 'ascend');

  limit = floor(length(correlations) * percentile);

  df = df(:, ids(1 : limit));

  ids = ids(limit + 1 : end);
