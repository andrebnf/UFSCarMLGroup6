function df = add_more_features(dataframe, degree)
  df = [dataframe];

  for i = 2 : degree
    df = [df normalize(dataframe .^ i)];
  end
end
