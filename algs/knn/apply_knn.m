function [labels, cost] = apply_knn(observations, dataframe, target_class, K, varargin)
  % Normaliza dados
  [normalized, mu, sigma] = normalizar(dataframe);

  % Transforma dados em matriz
  mu = repmat(mu, size(observations, 1), 1);
  sigma = repmat(sigma, size(observations, 1), 1);

  % Normaliza observacoes
  X = (observations - mu) ./ sigma;

  % Computa custo de treinamento

  labels_c = [];

  parfor i = 1 : size(normalized, 1)
    labels_c(i) = knn(normalized(i, :), normalized, target_class, K);
  end

  cost = knn_error(labels_c, target_class);

  % Computa labels
  labels = [];

  parfor i = 1 : size(observations, 1)
    labels(i) = knn(X(i, :), normalized, target_class, K);
  end
