function indices = kf_index(m, K, randomlyPermutate)
  if nargin <= 2
    randomlyPermutate = false;
  end

  indices = mod((0 : m - 1), K) + 1;

  if randomlyPermutate
    indices = indices(randperm(m));
  end
