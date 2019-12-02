function [doaEst] = rootmusicdoa(Cx, numSignals)
[Q,D] = eig(Cx);

% sort the eigenvalues and eigenvectors of the sensor covariance matrix
numElements = length(Cx);
[~, idxs] = sort(diag(D),'descend');
Q(:,1:numElements) = Q(:,idxs);
Q_N = Q(:,numElements-numSignals+1:end);
Q_NQ_NH = Q_N*Q_N';
      
% polynomial parameterization
quadraticForm = zeros(2*numElements-2,1);
for i = (1-numElements):(numElements-1)
    quadraticForm(i+(numElements+1)+1) = sum(diag(Q_NQ_NH,-i));
end

% find zeros of the polynomiral
music_zeros = roots(quadraticForm);
music_zeros = music_zeros(abs(music_zeros)>1);
[~,idx] = sort(abs(abs(music_zeros)-1),'ascend');
music_zeros = music_zeros(idx);
music_zeros = music_zeros(1:numSignals);

doaEst = pi-acos(1/pi*angle(music_zeros));
end
