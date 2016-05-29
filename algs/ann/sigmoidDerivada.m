function value = sigmoidDerivada(z)
  value = sigmoid(z) .* (1 - sigmoid(z));
end
