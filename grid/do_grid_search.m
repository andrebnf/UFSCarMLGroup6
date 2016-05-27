function bests = do_grid_search(dfx, losses, grid_algs_enabled)
  bests = struct;

  bests.kNN = 136;
  bests.reglog = 110;
  bests.svm = 0.003;
  bests.reglin = 1;

  if isempty(grid_algs_enabled)
    return;
  end

  % Separa dados para grid search
  fprintf('Separando dados para grid search...\n\n');
  [~, training, ~, training_labels] = separate_data(dfx, losses, .3);

  training_labels_bool = double(training_labels > 0);

  fprintf('Iniciando grid search...\n\n');

  disp(grid_algs_enabled);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if find(strcmp(grid_algs_enabled, 'knn')) > 0
    upper_bound = floor(sqrt(size(training, 1)));

    if mod(upper_bound, 2) == 0
      upper_bound = upper_bound - 1;
    end

    constants = [primes(17) ceil(upper_bound / 2) upper_bound];

    constants = unique(constants(2 : end));

    bests.kNN = call_grid('kNN', 'K', ...
     constants, training, training_labels_bool, @apply_knn, @knn_error);
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if find(strcmp(grid_algs_enabled, 'reglog')) > 0
    constants = (20 : 6 : 110);

    bests.reglog = call_grid('Regressao Logistica', 'lambda', ...
      constants, training, training_labels_bool, @apply_reglog, @reglog_error);
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if find(strcmp(grid_algs_enabled, 'svm')) > 0
    constants = (0.003 : .001  : 0.01);

    bests.svm = call_grid('SVM', 'C', ...
      constants, training, training_labels_bool, @apply_svm, @svm_error);
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  if find(strcmp(grid_algs_enabled, 'reglin')) > 0
    constants = [1, 3, 4];

    bests.reglin = call_grid('Regressao Linear', 'Grau do polinomio', ...
      constants, training, training_labels_bool, @apply_reglin, @reglin_error);
  end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
