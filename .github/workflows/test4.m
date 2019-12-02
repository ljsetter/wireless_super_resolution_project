clear all
close all

N = 100; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad([5 85]'); % direction of arrival of signals
Mag = [1 0.5];
rho = 0; % correlation
snr = inf; % snr

k = length(theta);
%signals = Mag'.*exp(1j*2*pi*rand(k,N)-pi);
signals = Mag'.*exp(1j*2*pi*rand(k,N)-pi);

% steering vectors
V = exp(-1j*pi*(0:M-1)'*cos(theta)');
snapshots = V*signals;
snapshots = awgn(snapshots, snr);