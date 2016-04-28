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

% Separa dados para selecao de features e treinamento
[df_piece, df, losses_piece, losses] = separate_data(df, losses, .2);

% Realiza operacoes nas features, removendo e criando novas no subset de selecao
[~, ids1, ids2] = featurize(df_piece, (losses_piece > 0));

% Remove features e as cria na base de treinamento
dfx = reproduce(df, ids1, ids2);

% Normalizando dados
fprintf('Normalizando dados...\n\n');
dfx = normalize(dfx);

% Limpando dados
fprintf('Removendo colunas de desvio <= 0 ou com dados invalidos...\n\n');
dfx = post_cleaning(dfx);
ptm(dfx);

% Separa dados para treinamento e teste
fprintf('Separando dados de treinamento e testes...\n\n');
[training, testing, training_labels, labels] = separate_data(dfx, losses, .3);

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
