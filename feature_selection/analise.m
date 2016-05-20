function [df, losses, U, S] = analise(dataframe, labels)
  df = dataframe;
  losses = labels;

  fprintf('Limpando dados...\n\n');

  % Remove a coluna de ids
  fprintf('\tRemovendo coluna de ids...\n\n');

  df(:, 1) = [];

  ptm(df);

  % Substitui observacoes com NaN pela media ou moda dependendo do tipo
  fprintf('\tImputando valores desconhecidos...\n\n');

  is_categorical = categorical_features(df);

  C = df(:, is_categorical);
  R = df(:, ~is_categorical);

  MODA = mode(C);
  MEDIA = nanmean(R);

  [~, c_c] = find(isnan(C));
  [~, c_r] = find(isnan(R));

  C(isnan(C)) = MODA(c_c);
  R(isnan(R)) = MEDIA(c_r);

  df = [C R];

  ptm(df);

  % Remove colunas duplicadas para evitar bias
  fprintf('\tRemovendo features duplicadas...\n\n');

  df = unique(df', 'rows')';

  ptm(df);

  fprintf('Selecionando features...\n\n');

  % Remove todas as colunas com desvio padrao = 0
  fprintf('\tRemovendo todas as colunas com desvio padrao = 0...\n\n');

  [df, ~] = remove_by_deviation(df, 0);

  ptm(df);

  % Normaliza dados
  fprintf('\tNormalizando dados...\n\n');

  df = normalize(df);

  % Aplica PCA
  [df, U, S] = apply_pca(df, 241);

  ptm(df);
