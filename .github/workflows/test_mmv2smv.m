close all; clearvars; clc;


%% 2 signals
N = 100; % number of samples
M = 100; % number of array elements (lamda/2 spacing)
theta = deg2rad([5 85]'); % direction of arrival of signals
rho = eye(length(theta)); % correlation
snr = inf; % snr

Y = siggen(N, M, theta, rho, snr);
e = mmv2smv(Y,length(theta));
plot(real(e))

%% 3 signals
N = 100; % number of samples
M = 100; % number of array elements (lamda/2 spacing)
theta = deg2rad([0 30 150]'); % direction of arrival of signals
rho = eye(length(theta)); % correlation
snr = inf; % snr

Y = siggen(N, M, theta, rho, snr);
e = mmv2smv(Y,length(theta));
plot(abs(fft(e)))

 