function [J, grad] = funcaoCusto(theta, X, y)
  %COMPUTARCUSTO Calcula o custo da regressao linear
  %   J = COMPUTARCUSTO(X, y, theta) calcula o custo de usar theta como
  %   parametro da regressao linear para ajustar os dados de X e y

  % Initializa algumas variaveis uteis
  m = length(y); % numero de exemplos de treinamento
  h = X * theta;

  % Atribui e retorna o custo da regressao linear
  J = (1 / (2 * m)) * sum((h - y) .^ 2);

  grad = (1 / m) * X' * (h - y);
end
