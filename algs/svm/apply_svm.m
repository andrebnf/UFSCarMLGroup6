function [labels, cost, model] = apply_svm(observations, dataframe, target_class, c, varargin)
  addpath('./algs/svm/libsvm/matlab/');

  cmdLinear = sprintf('-t 0 -c %d -q', c);

  model = svmtrain(target_class, dataframe, cmdLinear);

  y = zeros(size(observations, 1), 1);

  labels = svmpredict(y, observations, model, '-q');

  labels_c = svmpredict(target_class, dataframe, model, '-q');

  value = evaluate(labels_c, target_class);
  cost = value.mse;
end
