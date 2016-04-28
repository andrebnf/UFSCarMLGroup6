function [df, losses] = initial_cleaning(dataframe, labels)
  df = dataframe;
  losses = labels;

  fprintf('Limpando os dados...\n\n');
  % Remove a coluna de ids
  df(:, 1) = [];

  ptm(df);

  % Remove colunas duplicadas para evitar bias
  df = unique(df', 'rows')';

  % Remove as linhas que tem valores NaN
  losses = losses(~any(isnan(df), 2), :);
  df = df(~any(isnan(df), 2), :);

  ptm(df);
