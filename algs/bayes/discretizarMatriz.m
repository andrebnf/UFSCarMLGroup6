function X = discretizarMatriz(X, edges)
  n = length(edges);

  for i = 1 : n
    X(:, i) = discretize(X(:, i), edges{i});
  end
end
