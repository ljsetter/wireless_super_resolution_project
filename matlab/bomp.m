function [S] = bomp(y,A,k,eta)
N = length(y); % signal length
S = []; % support vector indices
R = y; % residual
idxs = 1:size(A,2); % indices for atoms

for kk = 1:k
    % find double coherence band of the selected atoms
    if kk == 1
        inBandIdxs = [];
    else
        inBandIdxs = cband(A,cband(A,S,eta),eta);
    end
    % find atoms not in band
    outBandIdxs = find(~ismember(idxs,inBandIdxs));
    outBandA = A(:,outBandIdxs);
    % find the next atom, can't be in band
    [~,idxPos] = max(outBandA'*R);
    S = [S; outBandIdxs(idxPos)];
    % compute residual
    atoms = A(:,S);
    Pperp = eye(N)-atoms*pinv(atoms);
    R = Pperp*y;
end