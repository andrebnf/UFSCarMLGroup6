function [labels, cost, model] = apply_svm(observations, dataframe, target_class, c, observations_labels, varargin)
  addpath('./algs/svm/libsvm/matlab/');

  cmdLinear = sprintf('-t 0 -c %d -q', c);

  model = svmtrain(target_class, dataframe, cmdLinear);

  labels = zeros(size(observations, 1), 1);

  x = svmpredict(labels, observations, model, '-q');

  value = evaluate(x, observations_labels);
  cost = value.mse;
end
