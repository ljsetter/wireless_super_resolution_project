function [e] = mmv2smv(Y,k)
% covariance matrix of snapshots
C = cov(Y.');
% sort eigenvalues/eigenvectors by descending eigenvalues, keep k largest
[V,lambda] = eig(C,'vector');
[lambda,idx] = sort(lambda,'descend');
lambda = lambda(1:k);
V = V(:,idx(1:k));

% take linear combination of the most significant eigenvectors weighted
% by eigenvalues
e = V*(lambda/sum(lambda));
end