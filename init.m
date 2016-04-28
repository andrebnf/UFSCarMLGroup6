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

df = importfile('train_v2.csv', 2, 100);

%% Ajusta colunas
losses = df.loss;
df.loss = [];
