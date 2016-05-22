function [labels, cost, theta] = apply_reglog(observations, dataframe, target_class, lambda, varargin)
  [m, n] = size(dataframe);
  [m2, n2] = size(observations);

  X = [ones(m, 1) dataframe];
  T = [ones(m2, 1) observations];

  %  Inicializa os parametros que serao ajustados
  theta_inicial = zeros(n + 1, 1);

  %  Definicao das opcoes para fminunc
  opcoes = optimset('GradObj', 'on', 'MaxIter', 400, 'Display', 'off');

  %  Executa fminunc para encontrar o theta otimo
  %  A funcao retornara theta e o custo
  [theta, cost] = ...
  	fminunc(@(t)(funcaoCustoRegLog(t, X, target_class, lambda)), theta_inicial, opcoes);

  theta_matrix = repmat(theta', m2, 1);
  labels = sigmoid(sum(T .* theta_matrix, 2)) >= 0.5;
