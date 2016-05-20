function [head, tail, head_labels, tail_labels] = separate_data(dataframe, labels, ratio)
  len = floor(size(dataframe, 1) * ratio);

  head = dataframe(1 : len, :);
  tail = dataframe(len + 1 : end, :);

  head_labels = labels(1 : len, :);
  tail_labels = labels(len + 1 : end, :);
