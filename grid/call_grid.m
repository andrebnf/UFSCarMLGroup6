function [c, errors] = call_grid(name, constant_name, constants, training, training_labels, method, error_fn)
  fprintf('Grid search para %s...\n\n', name);

  disp(constants);

  [c, ~, errors] = grid_search(...
    training, training_labels, method, error_fn, constants);

  figure;
    plot(errors(: , 1), errors(: , 2), 'b-o');
    hold on;
    xlabel(constant_name);
    ylabel('Error');
    title(sprintf('Grid search para o %s', name));
  hold off;
