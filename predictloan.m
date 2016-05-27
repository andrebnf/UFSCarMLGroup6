%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Loan Default Prediction - Imperial College London
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inicializacao
clear; close all; clc;

%% Carrega scripts
addpath('./util');
addpath('./feature_selection');
addpath('./algs/pca');
addpath('./algs/reglin');
addpath('./algs/svm/libsvm/matlab/');

%% Carrega os dados do arquivo
fprintf('Carregando os dados...\n\n');

load('loan-predict.mat');

[df, losses] = importfile('test_v2.mat', 1);

% Realiza operacoes nas features e observacoes
[df, ids] = reapply([df losses], modifiers);

labels = svmpredict(zeros(length(losses), 1), df, models.classificador, '-q');

dfx = df(labels == 1, :);

labels(labels == 1, :) = [ones(size(dfx, 1), 1) dfx] * models.regressor;

dlmwrite('predicted-labels.csv', [ids labels], 'delimiter', ',', 'precision', 10);
system('echo -e "id,loss\n$(cat predicted-labels.csv)" > predicted-labels.csv');
