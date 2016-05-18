function value = kfcv(dataframe, labels, method, errorMeasure, K)
  if nargin <= 4
    K = 10;
  end

  m = size(dataframe, 1);

  indices = kf_index(m, K);

  errors = zeros(K, 1);

  parfor k = 1 : K
    training = dataframe(indices == k, :);
    validation = dataframe(indices ~= k, :);

    training_labels = labels(indices == k);
    validation_labels = labels(indices ~= k);

    result = method(validation, training, training_labels);

    errors(k) = errorMeasure(result, validation_labels);
  end

  value = sum(errors) / K;
