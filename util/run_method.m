function [errors, statistic, testing, training, testing_labels, training_labels] = run_method(name, dataframe, labels, method, err_method, varargin)
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

  parfor i = 1 : N
    n = ranges(i);

    fprintf('%d ', n);

    rest = cell(1, nOutArgs - 2);

    [predicted, training_err, rest{:}] = method(...
      testing, training(1 : n, :), training_labels(1 : n, :), varargin{:});

    testing_err = err_method(predicted, testing_labels, testing, varargin{:}, rest{:});

    errors(i, :) = [training_err testing_err];

    EVALUATES(i) = evaluate(predicted, testing_labels);
  end

  fprintf('\n\nEstatisticas para o %s:\n\n', name);
  disp(EVALUATES(N));

  statistic = EVALUATES(N);

  disp(errors);

  % Plota curva de aprendizado
  figure;
    hold on;
    plot(ranges, errors(:, 1), 'r-', ranges, errors(:, 2), 'b--');
    title(sprintf('Curva de aprendizado do %s', name));
    xlabel('Quantidade de amostras');
    ylabel('Erro');
    legend('Erro de treinamento', 'Erro de teste');
  hold off;
