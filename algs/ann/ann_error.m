function value = ann_error(~, expected, X, HIDDEN, NEURONS, OUTPUTS, lambda, thetas, varargin)
  value = funcaoCustoNN(thetas, HIDDEN, NEURONS, OUTPUTS, X, expected, lambda);
end
