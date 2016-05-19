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

try
  matlablpool
catch
  try
    parpool
  catch
    disp('(Nao encontrou nenhum metodo para comp. paralela. Iniciando sem.)\n')
  end
end

GRID_SEARCH = false;

%% Carrega funcoes de selecao de atributos
addpath('./feature_selection');
addpath('./model_selection');
addpath('./util');
addpath('./algs/knn');
addpath('./algs/reglog');
addpath('./algs/pca');

%% Carrega os dados do arquivo
fprintf('Carregando os dados...\n\n');

[df, losses] = importfile('train_v2.mat', 1, 500);

ptm(df);

% Realiza operacoes nas features e observacoes
[dfx, losses, U, S] = analise(df, losses);

% Separa dados para treinamento e teste
fprintf('Separando dados de treinamento e testes...\n\n');
[testing, training, labels, training_labels] = separate_data(dfx, losses, .3);

training_labels_bool = double(training_labels > 0);
labels_bool = double(labels > 0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GRID SEARCH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if GRID_SEARCH
  fprintf('Iniciando grid search...\n\n');

  fprintf('Grid search para kNN...\n\n');

  upper_bound = floor(sqrt(size(training, 1)));

  if mod(upper_bound, 2) == 0
    upper_bound = upper_bound - 1;
  end

  range = [3 5 9 ceil(upper_bound / 2) upper_bound];

  disp(range);

  [knn_K, ~, knn_grid_errors] = grid_search(training, training_labels_bool, @apply_knn, @knn_error, range);

  plot(knn_grid_errors(: , 1), knn_grid_errors(: , 2), 'b-o');
  hold on;
  xlabel('K');
  ylabel('Error');
  title('Grid search para o kNN');
  hold off;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CLASSIFICADORES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


run_method('KNN', labels_bool, ...
  @()(apply_knn(testing, training, training_labels_bool, 95)));

run_method('Regressao logistica', labels_bool, ...
  @()(apply_reglog(testing, training, training_labels_bool)));
