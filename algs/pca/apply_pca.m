function [df, U, S] = apply_pca(dataframe)
  fprintf('\tAplicando PCA...\n\n');

  [U, S] = pca(dataframe);

  fprintf('\t\tBuscando o melhor K...\n\n');

  m = size(S, 1);
  diagonal = diag(S);
  total = sum(diagonal);

  fprintf('\t\t\tK = ');

  for k = 1 : m
    fprintf('%d', k);

    c = sum(diagonal(1 : k)) / total;

    if (1 - c <= 0.01)
      fprintf('.');
      break;
    end

    fprintf(', ');
  end

  fprintf('\n\n\t\tMELHOR K = %d!\n\n', k);

  df = projetarDados(dataframe, U, k);
