function value = reglin_error(~, expected, X, degree, theta, varargin)
  X = add_more_features(X, degree);

  value = funcaoCusto(theta, [ones(size(X, 1), 1) X], expected);
end
