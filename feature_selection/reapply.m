function [df, ids] = reapply(dataframe, modifiers)
  df = dataframe;

  fprintf('Limpando dados...\n\n');

  % Remove a coluna de ids
  fprintf('\tRemovendo coluna de ids...\n\n');

  ids = df(:, 1);

  df(:, 1) = [];

  ptm(df);

  % Substitui observacoes com NaN pela media ou moda dependendo do tipo
  fprintf('\tImputando valores desconhecidos...\n\n');

  C = df(:, modifiers.is_categorical);
  R = df(:, ~modifiers.is_categorical);

  [~, c_c] = find(isnan(C));
  [~, c_r] = find(isnan(R));

  C(isnan(C)) = modifiers.MODA(c_c);
  R(isnan(R)) = modifiers.MEDIA(c_r);

  df = [C R];

  ptm(df);

  % Remove colunas duplicadas para evitar bias
  fprintf('\tRemovendo features duplicadas...\n\n');

  A = df';
  df = A(modifiers.columns_repeated, :)';

  ptm(df);

  fprintf('Selecionando features...\n\n');

  % Remove todas as colunas com desvio padrao = 0
  fprintf('\tRemovendo todas as colunas com desvio padrao = 0...\n\n');

  df(:, modifiers.columns_deviation) = [];

  ptm(df);

  % Normaliza dados
  fprintf('\tNormalizando dados...\n\n');

  df = normalize(df);

  % Aplica PCA
  df = projetarDados(df, modifiers.U, 241);

  ptm(df);
