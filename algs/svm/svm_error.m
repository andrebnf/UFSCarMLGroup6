function value = svm_error(labels, expected, varargin)
  value = evaluate(labels, expected);
  value = 1 - value.acc;
end
