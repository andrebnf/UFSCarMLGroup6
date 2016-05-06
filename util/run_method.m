function [] = run_method(name, expected, fn)
  disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  fprintf('  %s\n', name);
  disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

  fprintf('\nRodando o %s...\n\n', name);
  labels = fn();

  fprintf('Estatisticas para o %s:\n\n', name);
  disp(evaluate(labels, expected));
