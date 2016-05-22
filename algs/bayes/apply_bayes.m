function [labels, cost] = apply_bayes(observations, dataframe, target_class, varargin)
	[dataframe, edges] = binify(dataframe);

	observations = discretizarMatriz(observations, edges);

	[probLoss, probPaid, laplacianLoss, laplacianPaid] = calcularProbabilidades(dataframe, target_class);

	total_loss_prob = sum(target_class == 1) / size(target_class, 1);
	total_paid_prob = sum(target_class == 0) / size(target_class, 1);

	labels = classificacaoBayes(...
		observations, total_loss_prob, total_paid_prob, ...
		probLoss, probPaid, laplacianLoss, laplacianPaid);

	labels_c = classificacaoBayes(...
		dataframe, total_loss_prob, total_paid_prob, ...
		probLoss, probPaid, laplacianLoss, laplacianPaid);

	cost = bayes_error(labels_c, target_class);
end
