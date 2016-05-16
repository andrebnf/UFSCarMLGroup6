function value = knn_error(labels, expected)
  value = evaluate(labels, expected);
  value = 1 - value.acc;
