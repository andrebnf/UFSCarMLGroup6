function [J, grad] = funcaoCusto(theta, X, y, lambda)
  %FUNCAOCUSTO Calcula o custo da regressao logistica
  %   J = FUNCAOCUSTO(X, y, theta) calcula o custo de usar theta como
  %   parametro da regressao logistica para ajustar os dados de X e y
  m = length(y);

  h = sigmoid(X * theta);

  y_logical = (y == 1);

  J = sum(-log(h(y_logical))) + sum(-log(1 - h(~y_logical)));
  J = (1 / m) * J;

  % J = (1 / m) * ((-y' * log(h)) - ((1 - y') * log(1 - h)));

  grad = (1 / m) * X' * (h - y);

  % Regularizacao

  J = J + (lambda / (2 * m)) * sum(theta(2 : end) .^ 2);

  grad(2 : end) = grad(2 : end) + (lambda / m) * theta(2 : end);
end
