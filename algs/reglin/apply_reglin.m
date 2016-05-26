function [estimates, cost, theta] = apply_reglin(observations, dataframe, target_class, degree, varargin)
  dataframe = add_more_features(dataframe, degree);
  observations = add_more_features(observations, degree);

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
  	fminunc(@(t)(funcaoCusto(t, X, target_class)), theta_inicial, opcoes);

  estimates = T * theta;
end
