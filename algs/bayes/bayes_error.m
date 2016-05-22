function value = bayes_error(labels, expected, varargin)
  value = evaluate(labels, expected);
  value = 1 - value.acc;
