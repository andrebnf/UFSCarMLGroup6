function [df, ids] = add_correlated_features(dataframe)
  correlations = corr(dataframe);

  % Ignora atributos iguais
  correlations(correlations == 1) = 0;

  [L, C] = find(correlations > 0.9999);

  df = dataframe;

  j = size(df, 2);
  k = 0;

  visited = zeros(size(df, 2), size(df, 2));
  ids = [];

  for i = 1 : length(L)
    if visited(L(i), C(i)) || visited(C(i), L(i))
      continue;
    end

    j = j + 1;
    k = k + 1;

    df(:, j) = (df(:, L(i)) - df(:, C(i))) .^ 2;

    visited(L(i), C(i)) = true;

    ids(k, :) = [L(i) C(i)];
  end
