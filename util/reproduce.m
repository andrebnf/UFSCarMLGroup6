function df = reproduce(dataframe, ids1, ids2, ids3)
  fprintf('Aplicando operacoes nos indices da matriz de treinamento...\n\n');

  df = dataframe;

  fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));

  df(:, ids1) = [];

  fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));

  df(:, ids2) = [];

  fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));

  j = size(df, 2);

  for i = 1 : length(ids3)
    k = ids3(i, :);

    df(:, j + i) = (df(k(1)) - df(k(2))) .^ 2;
  end

  fprintf('\t- matriz com %dx%d\n\n', size(df, 1), size(df, 2));
