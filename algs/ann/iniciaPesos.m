function thetas = iniciaPesos(hidden, neurons, outputs, inputs)
  thetas = [];

  x = randInit(inputs, neurons);

  thetas = [thetas; x(:)];

  for i = 2 : hidden
    x = randInit(neurons, neurons);
    thetas = [thetas; x(:)];
  end

  x = randInit(neurons, outputs);
  thetas = [thetas; x(:)];
end
