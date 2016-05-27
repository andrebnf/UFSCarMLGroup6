function [model] = run_method(name, dataframe, labels, method, err_method, LAST_ONLY, varargin)
  disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  fprintf('  %s\n', name);
  disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

  [testing, training, testing_labels, training_labels] = separate_data(dataframe, labels, .3);

  ranges = ceil((.2 : .2 : 1) * size(training, 1));

  N = length(ranges);

  errors = zeros(N, 2);

  nOutArgs = nargout(method);

  EVALUATES(N) = evaluate([], []);

  fprintf('\nRodando o %s...\n\n\tN = ', name);

  model = cell(N, nOutArgs - 2);

  j = 1;

  if LAST_ONLY
    j = N;
  end

  parfor i = j : N
    n = ranges(i);

    fprintf('%d ', n);

    rest = cell(1, nOutArgs - 2);

    [predicted, training_err, rest{:}] = method(...
      testing, training(1 : n, :), training_labels(1 : n, :), varargin{:});

    testing_err = err_method(...
      predicted, testing_labels, testing, varargin{:}, rest{:});

    errors(i, :) = [training_err testing_err];

    EVALUATES(i) = evaluate(predicted, testing_labels);

    model{i} = rest;
  end

  model = model{N};

  fprintf('\n\nEstatisticas para o %s:\n\n', name);
  disp(EVALUATES(N));

  statistic = EVALUATES;

  disp(errors);

  if ~LAST_ONLY
    % Plota curva de aprendizado
    figure;
      hold on;
      plot(ranges, errors(:, 1), 'r-', ranges, errors(:, 2), 'b--');
      title(sprintf('Curva de aprendizado do %s', name));
      xlabel('Quantidade de amostras');
      ylabel('Erro');
      legend('Erro de treinamento', 'Erro de teste');
    hold off;
  end
