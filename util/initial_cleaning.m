function [df, losses] = initial_cleaning(dataframe, labels)
  df = dataframe;
  losses = labels;

  fprintf('Limpando dados...\n\n');

  % Remove a coluna de ids
  fprintf('\tRemovendo coluna de ids...\n\n');

  df(:, 1) = [];

  ptm(df);

  % Remove colunas duplicadas para evitar bias
  fprintf('\tRemovendo colunas duplicadas...\n\n');

  df = unique(df', 'rows')';

  ptm(df);

  % Remove as linhas que tem valores NaN
  fprintf('\tRemovendo observacoes com NaN...\n\n');

  losses = losses(~any(isnan(df), 2), :);
  df = df(~any(isnan(df), 2), :);

  ptm(df);

  % Remove todas as colunas com desvio padrao = 0
  fprintf('\tRemovendo todas as colunas com desvio padrao = 0...\n\n');

  [df, ~] = remove_by_deviation(df, 0);

  ptm(df);
