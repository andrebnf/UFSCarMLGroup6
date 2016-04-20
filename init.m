%% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Loan Default Prediction - Imperial College London
%

%% Inicializacao
clear ; close all; clc

% Carrega os dados do arquivo
fprintf('Carregando os dados...\n\n');

df = importfile('train_v2.csv', 2, 1000);
