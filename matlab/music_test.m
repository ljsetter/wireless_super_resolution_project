%%
close all; clearvars; clc

%% 1 signal 
N = 100; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad(80); % direction of arrival of signals
rho = 0; % correlation
snr = inf; % snr
gridElements = 360;

Y = siggen(N, M, theta, rho, snr);

covmat = cov(Y');
rad2deg(musicdoa(covmat, length(theta), gridElements))

%% 2 signals 
N = 100; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad([80 100]'); % direction of arrival of signals
rho = eye(2); % correlation
snr = inf; % snr
gridElements = 360;

Y = siggen(N, M, theta, rho, snr);

covmat = cov(Y');
rad2deg(musicdoa(covmat, length(theta), gridElements))

%% 2 signals, noisy
N = 100; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad([80 100]'); % direction of arrival of signals
rho = eye(2); % correlation
snr = 20; % snr
gridElements = 360;

Y = siggen(N, M, theta, rho, snr);

covmat = cov(Y');
rad2deg(musicdoa(covmat, length(theta), gridElements))

%% 2 signals, correlated (not affecting it really, don't know why)
N = 1000; % number of samples
M = 8; % number of array elements (lamda/2 spacing)
theta = deg2rad([80 100]'); % direction of arrival of signals
rho = .95; % correlation
snr = 20; % snr
gridElements = 360;

Y = siggen(N, M, theta, rho, snr);

covmat = cov(Y');
sort(rad2deg(musicdoa(covmat, length(theta), gridElements)))