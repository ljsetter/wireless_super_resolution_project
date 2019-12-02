function [C] = cov2(X)
N = size(X,2);
C = 1/N*(X*X');
end