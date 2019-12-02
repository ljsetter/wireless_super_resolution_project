function [S] = lo(A,y,S,eta)
N = length(y);
% we will optimize all index choices in the support
for n = 1:length(S)
    % current support index to optimize
    k = S(n);
    min = Inf;
    argmin = k;
    % consider all atoms in the coherence band of the kth atom
    band = cband(A,k,eta);
    for j = 1:length(band)
        S(n) = band(j);
        % find reconstruction error using current set of atoms
        An = A(:,S);
        error = norm((eye(N)-An*pinv(An))*y);
        if error < min
            min = error;
            argmin = band(j);
        end
    end
    % choose the atom which yielded the lowest error
    S(n) = argmin;
end
end