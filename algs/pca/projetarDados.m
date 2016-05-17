function Z = projetarDados(X, U, K)
  Z = X * U(1 : K, :)';
end
