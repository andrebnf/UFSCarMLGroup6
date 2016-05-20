function [J, grad] = funcaoCusto(theta, X, y, lambda)
  %FUNCAOCUSTO Calcula o custo da regressao logistica
  %   J = FUNCAOCUSTO(X, y, theta) calcula o custo de usar theta como
  %   parametro da regressao logistica para ajustar os dados de X e y
  m = length(y);

  h = sigmoid(X * theta);

  J = (1 / m) * ((-y' * log(h)) - ((1 - y') * log(1 - h)));

  grad = (1 / m) * X' * (h - y);

  % Regularizacao

  J = J + (lambda / (2 * m)) * sum(theta(2 : end) .^ 2);

  grad(2 : end) = grad(2 : end) + (lambda / m) * theta(2 : end);
end
