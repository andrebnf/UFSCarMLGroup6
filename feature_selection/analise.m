function [df, losses, modifiers] = analise(dataframe, labels, PCA)
  modifiers = struct;

  df = dataframe;
  losses = labels;

  fprintf('Limpando dados...\n\n');

  % Remove a coluna de ids
  fprintf('\tRemovendo coluna de ids...\n\n');

  df(:, 1) = [];

  ptm(df);

  % Substitui observacoes com NaN pela media ou moda dependendo do tipo
  fprintf('\tImputando valores desconhecidos...\n\n');

  modifiers.is_categorical = categorical_features(df);

  C = df(:, modifiers.is_categorical);
  R = df(:, ~modifiers.is_categorical);

  modifiers.MODA = mode(C);
  modifiers.MEDIA = nanmean(R);

  [~, c_c] = find(isnan(C));
  [~, c_r] = find(isnan(R));

  C(isnan(C)) = modifiers.MODA(c_c);
  R(isnan(R)) = modifiers.MEDIA(c_r);

  df = [C R];

  ptm(df);

  % Remove colunas duplicadas para evitar bias
  fprintf('\tRemovendo features duplicadas...\n\n');

  [df, modifiers.columns_repeated, ~] = unique(df', 'rows');

  df = df';

  ptm(df);

  fprintf('Selecionando features...\n\n');

  % Remove todas as colunas com desvio padrao = 0
  fprintf('\tRemovendo todas as colunas com desvio padrao = 0...\n\n');

  [df, modifiers.columns_deviation] = remove_by_deviation(df, 0);

  ptm(df);

  % Normaliza dados
  fprintf('\tNormalizando dados...\n\n');

  df = normalize(df);

  % Aplica PCA
  [df, modifiers.U, modifiers.S] = apply_pca(df, PCA);

  ptm(df);
