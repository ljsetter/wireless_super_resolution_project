close all; clearvars; clc;

%%
gridElements = 400;
numElements = 4;

thetaGrid = linspace(0,pi,gridElements);
v = [];
for i = 1:numel(thetaGrid)
    v = [v exp(-1j*pi*(0:numElements-1)'*cos(thetaGrid(i)))];
end

plot(abs(fft(v(:,001:200))))


%%
mu = 50;
k = 4;
sigma = 5;
M = mu + sigma*randn(1000,k);
c = 0;
R = ones(k)*c+eye(k)*(1-c);
L = chol(R);
M = M*L;
corr(M)

%%
N = 1000; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad([0 30 150]'); % direction of arrival of signals
rho = 1; % correlation
snr = inf; % snr
k = length(theta);
Y = siggen(N, M, theta, rho, snr);
