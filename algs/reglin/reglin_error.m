function value = reglin_error(~, expected, X, theta, varargin)
  value = funcaoCusto(theta, [ones(size(X, 1), 1) X], expected);
end
