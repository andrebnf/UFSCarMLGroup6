function [labels, cost] = apply_svm(observations, dataframe, target_class, varargin)
  addpath('./algs/svm/libsvm/matlab/');

  C = 1;
  gamma = 0.07;
  cmd = sprintf('-t 2 -c %d -g %.3f -q', C, gamma);

  model = svmtrain(target_class, dataframe, cmd);

  labels_c = svmpredict(target_class, dataframe, model);
  cost = svm_error(labels_c, target_class);

  labels = svmpredict(zeros(size(observations, 1), 1), observations, model);
end
