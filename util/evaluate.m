function data = evaluate(labels, expected)
  tp = length(intersect(find(labels == 1), find(expected == 1)));
  tn = length(intersect(find(labels == 0), find(expected == 0)));
  fp = length(find(labels == 1)) - tp;
  fn = length(find(labels == 0)) - tn;

  data = table;

  data.tp = tp;
  data.tn = tn;
  data.fp = fp;
  data.fn = fn;

  data.acc = (tp + tn) / (tp + tn + fp + fn);

  data.prec_p = tp / (tp + fp);
  data.prec_n = tn / (tn + fn);

  data.rec_p = tp / (tp + fn);
  data.rec_n = tn / (fp + tn);

  data.f_p = 2 * (data.rec_p * data.prec_p) / (data.rec_p + data.prec_p);
  data.f_n = 2 * (data.rec_n * data.prec_n) / (data.rec_n + data.prec_n);
