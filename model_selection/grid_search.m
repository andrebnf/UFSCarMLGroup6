function [x, value, errors] = grid_search(dataframe, labels, method, errorMeasure, C)
  C_length = length(C);

  errors = [C' zeros(C_length, 1)];

  for i = 1 : C_length
    c = C(i);

    fprintf('\tc = %d;\n', c);

    fn = @(validation, training, training_labels)(...
      method(validation, training, training_labels, c));

    errors(i, 2) = kfcv(dataframe, labels, fn, errorMeasure);
  end

  sorted_errors = sortrows(errors, [2, 1]);

  x = sorted_errors(1, 1);
  value = sorted_errors(1, 2);

  fprintf('\t\tMELHOR: c = %d, err = %d\n\n', x, value);
