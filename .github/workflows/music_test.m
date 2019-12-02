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
Mag = [1 1];

Y = siggen(N, M, theta, rho, snr, Mag);

angle1 = 80;
angle2 = 100;
success1 = 0;
covmat = cov(Y');
[~,idx,thetaGrid] = musicdoa(covmat, length(theta), gridElements);
S1 = idx';

success1 = CheckSuccess(success1, angle1, angle2, S1, rad2deg(thetaGrid));

%% 2 signals, noisy
N = 100; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad([80 100]'); % direction of arrival of signals
rho = eye(2); % correlation
snr = 20; % snr
gridElements = 360;

Mag = [1 1];

Y = siggen(N, M, theta, rho, snr, Mag);

covmat = cov(Y');
rad2deg(musicdoa(covmat, length(theta), gridElements))



%% 2 signals, correlated (not affecting it really, don't know why)
N = 100; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad([80 100]'); % direction of arrival of signals
rho = [1 .5; .5 1]; % correlation
snr = inf; % snr
gridElements = 360;
Mag = [1 1];

Y = siggen(N, M, theta, rho, snr, Mag);

covmat = cov(Y');
rad2deg(musicdoa(covmat, length(theta), gridElements))