function v = randInit(in, out)
  epsilon_init = 0.12;
  v = rand(out, 1 + in) * 2 * epsilon_init - epsilon_init;
end
