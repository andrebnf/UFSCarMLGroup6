function bests = do_grid_search(dfx, losses)
  % Separa dados para grid search
  fprintf('Separando dados para grid search...\n\n');
  [~, training, ~, training_labels] = separate_data(dfx, losses, .3);

  training_labels_bool = double(training_labels > 0);

  bests = struct;

  fprintf('Iniciando grid search...\n\n');

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % upper_bound = floor(sqrt(size(training, 1)));
  %
  % if mod(upper_bound, 2) == 0
  %   upper_bound = upper_bound - 1;
  % end
  %
  % constants = [primes(17) ceil(upper_bound / 2) upper_bound];
  %
  % constants = unique(constants(2 : end));
  % 
  % bests.kNN = call_grid('kNN', 'K', ...
  %  constants, training, training_labels_bool, @apply_knn, @knn_error);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  constants = (20 : 6 : 110);

  bests.reglog = call_grid('Regressao Logistica', 'lambda', ...
    constants, training, training_labels_bool, @apply_reglog, @reglog_error);
