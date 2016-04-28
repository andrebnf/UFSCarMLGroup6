function [df] = post_cleaning(dataframe)
  df = dataframe;

  %% Remove todas as colunas com desvio padrao = 0
  fprintf('Removendo todas as colunas com desvio padrao = 0...\n\n');

  [df, ~] = remove_by_deviation(df, 0);
  fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));
