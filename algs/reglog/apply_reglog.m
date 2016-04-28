function labels = apply_reglog(observations, dataframe, target_class)
  [m, n] = size(dataframe);
  [m2, n2] = size(observations);

  X = [ones(m, 1) dataframe];
  T = [ones(m2, 1) observations];

  %  Inicializa os parametros que serao ajustados
  theta_inicial = zeros(n + 1, 1);

  [custo, grad] = funcaoCusto(theta_inicial, X, target_class);

  %  Definicao das opcoes para fminunc
  opcoes = optimset('GradObj', 'on', 'MaxIter', 400);

  %  Executa fminunc para encontrar o theta otimo
  %  A funcao retornara theta e o custo
  [theta, custo] = ...
  	fminunc(@(t)(funcaoCusto(t, X, target_class)), theta_inicial, opcoes);

  theta = repmat(theta', m2, 1);

  labels = sigmoid(sum(T .* theta, 2)) >= 0.5;
