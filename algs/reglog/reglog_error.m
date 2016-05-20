function value = reglog_error(~, expected, X, lambda, theta, varargin)
  value = funcaoCusto(theta, [ones(size(X, 1), 1) X], expected, lambda);
