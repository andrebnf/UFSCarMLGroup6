function df = reproduce(dataframe, ids1, ids2)
  fprintf('Aplicando operacoes nos indices da matriz de treinamento...\n\n');

  df = dataframe;

  ptm(df);

  df(:, ids1) = [];

  ptm(df);

  j = size(df, 2);

  for i = 1 : length(ids2)
    k = ids2(i, :);

    df(:, j + i) = (df(k(1)) - df(k(2))) .^ 2;
  end

  ptm(df);
