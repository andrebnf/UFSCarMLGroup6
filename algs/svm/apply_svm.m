function [labels, cost] = apply_svm(observations, dataframe, target_class, c, varargin)
    addpath('./algs/svm/libsvm/matlab/');

    cmdLinear = ['-t 0 -c ',num2str(c), ' -q'];
    
    model = svmtrain(target_class, dataframe, cmdLinear);
    labels = zeros(size(observations, 1), 1);
    [labels, accuracy, dec_values]  = svmpredict(labels, observations, model);
       
%     [md, nd] = size(dataframe);
%     gamma = 1/md;
%     cmdGaussian = ['-t 2 -c ',num2str(C), ' -g ',num2str(gamma), ' -q'];
%     modelGaussian = svmtrain(target_class, dataframe, cmdGaussian);
%     labels = zeros(size(observations, 1), 1);
%     [labels, accuracy, dec_values]  = svmpredict(labels, observations, modelGaussian);
     
    cost = 1 - accuracy(1);
end