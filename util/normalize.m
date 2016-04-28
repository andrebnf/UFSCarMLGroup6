function df = normalize(dataframe)
  MIN = 0;
  MAX = 1;

  df = dataframe;

  for i = 1 : size(df, 2)
    x = min(df(:, i));
    y = max(df(:, i));

    df(:, i) = (MIN + ((df(:, i) - x) / (y - x))) * (MAX - MIN);
  end
