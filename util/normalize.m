function df = normalize(dataframe)
  df = bsxfun(@minus, dataframe, mean(dataframe));
  df = bsxfun(@rdivide, df, std(df));
