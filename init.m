%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Loan Default Prediction - Imperial College London
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inicializacao
clear ; close all; clc

%% Carrega funcoes de selecao de atributos
addpath('./feature_selection');
addpath('./util');
addpath('./algs/knn');
addpath('./algs/reglog');

%% Carrega os dados do arquivo
fprintf('Carregando os dados...\n\n');

[df, losses] = importfile('train_v2.csv', 2, 100);

ptm(df);

% Limpeza inicial
[df, losses] = initial_cleaning(df, losses);

% Realiza operacoes nas features, removendo e criando novas no subset de selecao
df = featurize(df, (losses > 0));

% Normalizando dados
fprintf('Normalizando dados...\n\n');
dfx = normalize(df);


% Separa dados para treinamento e teste
fprintf('Separando dados de treinamento e testes...\n\n');
[testing, training, labels, training_labels] = separate_data(dfx, losses, .3);

training_labels_bool = training_labels > 0;
labels_bool = labels > 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASSIFICADORES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('  KNN');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

fprintf('\nRodando o KNN...\n\n');
knn_labels = apply_knn(testing, training, training_labels_bool, 5);

fprintf('Estatisticas para o KNN:\n\n');
disp(evaluate(knn_labels, labels_bool));

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('  Regressao logistica');
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

fprintf('\nRodando a regressao logistica...\n\n');
reglog_labels = apply_reglog(testing, training, training_labels_bool);

fprintf('Estatisticas para a regressao logistica:\n\n');
disp(evaluate(reglog_labels, labels_bool));
