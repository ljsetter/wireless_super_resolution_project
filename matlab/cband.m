function [BS] = cband(A,S,eta)
% computes the coherence band of a set of atoms in a dictionary
%
% inputs
% A: atoms
% S: set to find coherence band of
% eta: minimum coherence to be in band
%
% outputs:
% BS: coherence band indices of atoms indexed by S

if isempty(S)
    BS = [];
else
    % normalize the atoms in A
    A = A./vecnorm(A);

    % find when the correlation between atoms indexed by S and all other atoms
    % is greater than eta
    idxs = A'*A(:,S) > eta;
    BS = find(any(idxs, 2));
end
end