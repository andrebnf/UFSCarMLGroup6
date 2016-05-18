function [] = preparefiles()
  system('sed ''s/NA/NaN/g'' train_v2.csv > train_v2.numeric.csv');
  data = csvread('train_v2.numeric.csv', 1, 0);
  save('train_v2.mat', 'data');
  delete('./train_v2.numeric.csv');
