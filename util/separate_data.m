function [head, tail, head_labels, tail_labels] = separate_data(dataframe, labels, ratio)
  len = floor(size(dataframe, 1) * ratio);

  head = dataframe(1 : len, :);
  tail = dataframe(len + 1 : end, :);

  head_labels = labels(1 : len, :);
  tail_labels = labels(len + 1 : end, :);

  fprintf('\t\t- matriz menor com %dx%d\n\n', size(head, 1), size(head, 2));
  fprintf('\t\t- matriz maior com %dx%d\n\n', size(tail, 1), size(tail, 2));
