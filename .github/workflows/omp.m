function [S] = omp(y,A,k)
N = length(y); % signal length
S = zeros(k,1); % support vector indices
R = y; % residual

for kk = 1:k
    % choose next atom
    [~,S(kk)] = max(A'*R);
    % compute residual
    atoms = A(:,S(1:kk));
    Pperp = eye(N)-atoms*pinv(atoms);
    R = Pperp*y;
end