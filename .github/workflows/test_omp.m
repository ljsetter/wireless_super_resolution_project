close all; clearvars; clc;

M = 32;
N = 128;
A = randn(M, N);
eta = .5;

idxs = [40 60 79 80];
k = length(idxs);
x = zeros(N, 1);
x(idxs) = 1;

y = A*x;

omp(y,A,k)
bomp(y,A,k,eta)
bloomp(y,A,k,eta)