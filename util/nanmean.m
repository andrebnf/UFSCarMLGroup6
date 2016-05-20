function result = nanmean(x)
  result = mean(x(~any(isnan(x), 2), :));
