function labels = apply_knn(observations, dataframe, target_class, K)
  % Normaliza dados
  [normalized, mu, sigma] = normalizar(dataframe);

  % Transforma dados em matriz
  mu = repmat(mu, size(observations, 1), 1);
  sigma = repmat(sigma, size(observations, 1), 1);

  % Normaliza observacoes
  X = (observations - mu) ./ sigma;

  % Computa labels
  labels = [];

  for i = 1 : size(observations, 1)
    labels(i) = knn(X(i, :), normalized, target_class, K);
  end
