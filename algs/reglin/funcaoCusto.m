function [J] = funcaoCusto( X, y, theta )
%COMPUTARCUSTO Calcula o custo da regressao linear
%   J = COMPUTARCUSTO(X, y, theta) calcula o custo de usar theta como 
%   parametro da regressao linear para ajustar os dados de X e y

% Initializa algumas variaveis uteis
m = length(y); % numero de exemplos de treinamento

% Atribui e retorna o custo da regressao linear
J = (1/(2*m)) * sum((  X * theta - y  ).^2);


end

