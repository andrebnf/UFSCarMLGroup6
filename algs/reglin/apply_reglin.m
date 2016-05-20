function [theta] = apply_reglin( dataframe, y )

fprintf('Calculando Gradiente Descente ...\n')

[m_, n] = size(dataframe);

m = length(y);




X = [ones(m, 1), dataframe]; % Adicionar uma coluna de 1s em x
%theta = zeros(2, 1); % Inicializa parmetros que serao ajustados
theta = zeros(n + 1, 1); % Inicializa parmetros que serao ajustados





% Algumas configuracoes do gradiente descente
iteracoes = 1500;
alpha = 0.01;

% calcula e exibe o custo inicial
%J = funcaoCusto(X, y, theta);


% chama o metodo do gradiente descente
% VOCE PRECISA COMPLETAR O CODIGO GRADIENTEDESCENTE.M
[theta] = gradienteDescente(X, y, theta, alpha, iteracoes);



end

