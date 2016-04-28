function deviations = deviation(dataframe)
  names = dataframe.Properties.VariableNames;

  for i = 1 : length(names)
    deviations(i) = std(dataframe.(char(names(i))));
  end
