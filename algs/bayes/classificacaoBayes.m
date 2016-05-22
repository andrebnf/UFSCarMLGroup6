function classes = classificacaoBayes(X, total_loss_prob, total_paid_prob, probLoss, probPaid, laplacianLoss, laplacianPaid)

  probSampleLoss = calcularProbSamples(X, probLoss, total_loss_prob, laplacianLoss);
  probSamplePaid = calcularProbSamples(X, probPaid, total_paid_prob, laplacianPaid);

  classes = double(probSampleLoss > probSamplePaid)';
end
