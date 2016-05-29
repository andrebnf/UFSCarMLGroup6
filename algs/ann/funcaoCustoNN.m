function [J, grad] = funcaoCustoNN(foldedThetas, hidden, neurons, outputs, X, y, lambda)
  n = size(X, 2);

  theta = unfoldTheta(foldedThetas, hidden, neurons, outputs, n);

  m = size(X, 1);

  Y = repmat((0 : outputs - 1), m, 1) == repmat(y, 1, outputs);

  INPUTS = cell(1, hidden + 1);

  INPUTS{1} = [ones(m, 1) X];

  for i = 2 : hidden + 1
    INPUTS{i} = [ones(m, 1) sigmoid(INPUTS{i - 1} * theta{i - 1})];
  end

  H = sigmoid(INPUTS{hidden + 1} * theta{hidden + 1});

  h = -Y .* log(H) - ((1 - Y) .* log(1 - H));

  J = (1 / m) * sum(sum(h));

  % regularization
  reg = 0;

  for i = 1 : (hidden + 1)
    reg = reg + sum(sum(theta{i}(:, 2 : end) .^ 2));
  end

  J = J + (lambda / (2 * m)) * reg;

  % Compute backpropagation errors
  deltas = cell(1, (hidden + 1));

  for i = 1 : (hidden + 1)
    deltas{i} = zeros(size(theta{i}));
  end

  for i = 1 : m
    errMatrix = [NaN; H(i, :)' - Y(i, :)'];

    for j = (hidden + 1) : -1 : 1
      deltas{j} = deltas{j} + (errMatrix(2 : end) * INPUTS{j}(i, :))';

      if j > 1
        errMatrix = theta{j} * errMatrix(2 : end) .* sigmoidDerivada(...
          [1; theta{j - 1}' * INPUTS{j - 1}(i, :)']);
      end
    end
  end

  % Compute gradients
  grad = [];

  for i = 1 : hidden + 1
    tmp = [zeros(size(theta{i}, 1), 1) theta{i}(:, 2 : end)];
    tmp = (1 / m) * deltas{i} + (lambda / m) * tmp;
    grad = [grad; tmp(:)];
  end
end
