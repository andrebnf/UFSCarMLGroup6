function thetas = unfoldTheta(folded, hidden, neurons, outputs, inputs)
  thetas = cell(1, hidden + 1);

  until = (inputs + 1) * neurons;

  thetas{1} = reshape(folded(1 : until), inputs + 1, neurons);

  for i = 2 : hidden
    from = until + 1;
    to = until + (neurons + 1) * neurons;

    thetas{i} = reshape(folded(from : to), neurons + 1, neurons);

    until = to;
  end

  thetas{hidden + 1} = reshape(folded(until + 1 : end), neurons + 1, outputs);
end
