function [probLoss, probPaid, laplacianLoss, laplacianPaid] = calcularProbabilidades(X, Y)
  [~, n] = size(X);

  losses = X(Y == 1, :);
  paid = X(Y == 0, :);

  ml = size(losses, 1);
  mp = size(paid, 1);

  probLoss = [];
  probPaid = [];

  laplacianLoss = [];
  laplacianPaid = [];

  for i = 1 : n
    bins = unique(X(:, i));
    M = length(bins);

    laplacianLoss(i) = (ml + M);
    laplacianPaid(i) = (mp + M);

    for j = 1 : length(bins)
      scopePerda = find(losses(:, i) == bins(j));
      scopePago = find(paid(:, i) == bins(j));

      probLoss(i, bins(j)) = (length(scopePerda) + 1) / laplacianLoss(i);
      probPaid(i, bins(j)) = (length(scopePago) + 1) / laplacianPaid(i);
    end
  end
end
