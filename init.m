%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Loan Default Prediction - Imperial College London
%

%% Inicializacao
clear ; close all; clc

%% Carrega funcoes de selecao de atributos
addpath('./feature_selection');
addpath('./util');
addpath('./algs/knn');

%% Carrega os dados do arquivo
fprintf('Carregando os dados...\n\n');

[df, losses] = importfile('train_v2.csv', 2, 100);

fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));

% Limpeza inicial
[df, losses] = initial_cleaning(df, losses);

% Separa dados para selecao de features e treinamento
[df_piece, df, losses_piece, losses] = separate_data(df, losses, .2);

% Coluna auxiliar com dados booleanos
losses_bool = (losses > 0);
losses_piece_bool = (losses_piece > 0);

% Realiza operacoes nas features, removendo e criando novas no subset de selecao
[~, ids1, ids2, ids3] = featurize(df_piece, losses_piece_bool);

% Remove features e as cria na base de treinamento
df = reproduce(df, ids1, ids2, ids3);
