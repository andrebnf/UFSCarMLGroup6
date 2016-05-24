function df = discretize(v, edges)
  LV = length(v);
  LE = length(edges);

  [m, n] = size(v);

  df = zeros(m, n);

  for i = 1 : LV
    df(i) = NaN;

    for j = 1 : (LE - 1)
      if v(i) >= edges(j) && v(i) < edges(j + 1)
        df(i) = j;
      end
    end
  end
end
