function value = svm_error(labels, expected, varargin)
  value = evaluate(labels, expected);
  value = value.mse;
end
