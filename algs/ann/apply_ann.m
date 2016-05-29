function [labels, cost, thetas] = apply_ann(observations, dataframe, target_class, HIDDEN, NEURONS, OUTPUTS, lambda)
  n = size(dataframe, 2);

  ini_theta = iniciaPesos(HIDDEN, NEURONS, OUTPUTS, n);

  opcoes = optimset('GradObj', 'on', 'MaxIter', 300, 'Display', 'off');

  [thetas, cost] = fminunc(...
    @(t)funcaoCustoNN(t, HIDDEN, NEURONS, OUTPUTS, dataframe, target_class, lambda), ini_theta, opcoes);

  labels = preditorNN(unfoldTheta(thetas, HIDDEN, NEURONS, OUTPUTS, n), observations);
end
