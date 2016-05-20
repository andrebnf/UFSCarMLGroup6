function value = kfcv(dataframe, labels, method, errorMeasure, variable, K)
  if nargin <= 5
    K = 10;
  end

  m = size(dataframe, 1);
  n = nargout(method);

  indices = kf_index(m, K);

  errors = zeros(K, 1);

  parfor k = 1 : K
    training = dataframe(indices == k, :);
    validation = dataframe(indices ~= k, :);

    training_labels = labels(indices == k);
    validation_labels = labels(indices ~= k);

    rest = cell(1, n - 2);

    [result, ~, rest{:}] = method(validation, training, training_labels, variable);

    errors(k) = errorMeasure(result, validation_labels, validation, variable, rest{:});
  end

  value = sum(errors) / K;
