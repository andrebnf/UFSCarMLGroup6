function mat = categorical_features(matrix)
  [m, n] = size(matrix);

  mat = zeros(1, n);

  parfor i = 1 : n
    M = matrix(:, i);
    M = M(~isnan(M));

    mat(i) = (sum(M == int32(M)) / length(M)) == 1;
  end

  mat = logical(mat);
