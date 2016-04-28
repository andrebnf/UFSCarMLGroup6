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

%% Carrega os dados do arquivo
fprintf('Carregando os dados...\n\n');

[df, losses] = importfile('train_v2.csv', 2, 100);

%% Remove a coluna de ids
df(:, 1) = [];

%% Remove todas as colunas com desvio padrao < 0.1
fprintf('Removendo todas as colunas com desvio padrao < 0.1...\n\n');

df = remove_by_deviation(df, .1);

% Seleciona o 4o quartil das colunas que tem maior correlacao com os labels
fprintf('Selecionando o 4o quartil das colunas que tem maior correlacao com os labels...\n\n');

df = remove_by_correlation(df, losses, .25);
