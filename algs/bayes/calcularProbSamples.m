function p = calcularProbSamples(samples, probabilities, total_class_prob, laplacian)
  [m, n] = size(samples);

  p = [];

  for i = 1 : m
    p(i) = total_class_prob;

    for j = 1 : n
      if isnan(samples(i, j))
        p(i) = 1 / laplacian(j);
      else
        p(i) = p(i) * probabilities(j, samples(i, j));
      end
    end
  end
end
