function [df, ids1, ids2, ids3] = featurize(dataframe, labels)
  df = dataframe;

  %% Remove todas as colunas com desvio padrao = 0
  fprintf('Removendo todas as colunas com desvio padrao = 0...\n\n');

  [df, ids1] = remove_by_deviation(df, 0);
  fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));

  % Elimina o 1o quartil em termos de relacao com a classe
  fprintf('Eliminando o 1o quartil em termos de relacao com a classe...\n\n');

  [df, ids2] = remove_by_correlation(df, labels, .75);
  fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));

  % Cria novas colunas com features de correlacao alta
  fprintf('Criando novas colunas com features de correlacao alta...\n\n');
  [df, ids3] = add_correlated_features(df);
  fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));
