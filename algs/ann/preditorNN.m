function classes = preditorNN(Theta, X)
  [m, ~] = size(X);
  N = length(Theta);

  classes = zeros(m, 1);

  for i = 1 : m
    x = [1 X(i, :)];

    for j = 1 : N
      x = [1 x * Theta{j}];
    end

    [~, classes(i)] = max(x(2 : end));
  end

  classes = classes - 1;
end
