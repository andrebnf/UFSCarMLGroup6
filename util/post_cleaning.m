function [df] = post_cleaning(dataframe)
  df = dataframe;

  %% Remove todas as colunas com desvio padrao = 0
  fprintf('Removendo todas as colunas com desvio padrao = 0...\n\n');

  [df, ~] = remove_by_deviation(df, 0);
  ptm(df);

  %% Remove todas as colunas com NaN
  fprintf('Removendo todas as colunas com NaN...\n\n');
  df = df(:, ~any(isnan(df), 1));
