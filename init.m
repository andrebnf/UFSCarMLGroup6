%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Universidade Federal de Sao Carlos - UFSCar, Sorocaba
%
%  Disciplina: Aprendizado de Maquina
%  Prof. Tiago A. Almeida
%
%  Loan Default Prediction - Imperial College London
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Inicializacao
clear ; close all; clc;

GRID_SEARCH = false;

try
  matlabpool;
catch
  try
    parpool;
  catch
    fprintf('Nao foi encontrado nenhum metodo para computacao paralela (ou ja esta rodando)\n\n');
  end
end

%% Carrega funcoes de selecao de atributos
addpath('./feature_selection');
addpath('./model_selection');
addpath('./util');
addpath('./grid');
addpath('./algs/knn');
addpath('./algs/reglin');
addpath('./algs/reglog');
addpath('./algs/pca');

%% Carrega os dados do arquivo
fprintf('Carregando os dados...\n\n');

[df, losses] = importfile('train_v2.mat', 1);

ptm(df);

% Realiza operacoes nas features e observacoes
[dfx, losses, U, S] = analise(df, losses);

%clear df;       sugestao, verificar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRID SEARCH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gs = struct;

% Dados encontrados em grid searches (para nao precisar executa-los)
gs.kNN = 136;
gs.reglog = 110;

if GRID_SEARCH
  gs = do_grid_search(dfx, losses);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASSIFICADORES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

losses_bool = double(losses > 0);

run_method('kNN', dfx, losses_bool, @apply_knn, @knn_error, gs.kNN);

run_method('Regressao logistica', dfx, losses_bool, @apply_reglog, @reglog_error, gs.reglog);
