function [df, ids] = remove_by_deviation(dataframe, treshold)
  deviations = std(dataframe);

  ids = find(deviations <= treshold);

  df = dataframe;

  df(:, ids) = [];
