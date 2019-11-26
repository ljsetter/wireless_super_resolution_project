function [doaEst] = musicdoa(Cx, numSignals, gridElements)
[Q,D] = eig(Cx);

% sort the eigenvalues and eigenvectors of the sensor covariance matrix
numElements = length(Cx);
[~, idxs] = sort(diag(D),'descend');
Q(:,1:numElements) = Q(:,idxs);
Q_N = Q(:,numElements-numSignals+1:end);

% compute the music spectrum
thetaGrid = linspace(0,pi,gridElements);
P_mu = zeros(size(thetaGrid));
for i = 1:numel(thetaGrid)
    v = exp(-1j*pi*(0:numElements-1)'*cos(thetaGrid(i)));
    P_mu(i) = 1/((Q_N'*v)'*(Q_N'*v));
end

% find the peaks of the music spectrum
[~,idx] = findpeaks(P_mu,'sortstr','descend','npeaks',numSignals); 
doaEst = thetaGrid(idx);
end