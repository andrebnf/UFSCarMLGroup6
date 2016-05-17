function [U, S] = pca(X)
  [U, S] = svd(cov(X));
end
