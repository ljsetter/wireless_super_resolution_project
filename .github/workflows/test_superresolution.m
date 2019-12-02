close all; clearvars; clc;

%% 1 signals
N = 100; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad([85]'); % direction of arrival of signals]
Mag = [1];
rho = 0; % correlation
snr = inf; % snr
k = length(theta);
Y = siggen(N, M, theta, rho, snr, Mag);

%% 2 signals
N = 100; % number of samples
M = 8; % number of array elements (lamda/2 spacing)
theta = deg2rad([5 85]'); % direction of arrival of signals
Mag = [1 0.5];
rho = 0; % correlation
snr = inf; % snr
k = length(theta);
Y = siggen(N, M, theta, rho, snr, Mag);

%% 3 signals
N = 100; % number of samples
M = 20; % number of array elements (lamda/2 spacing)
theta = deg2rad([0 30 150]'); % direction of arrival of signals
Mag = ones(1,3);
%Mag = [1 1 0.5];
rho = 0; % correlation
snr = inf; % snr
k = length(theta);
Y = siggen(N, M, theta, rho, snr, Mag);

%% doa estimation
e = mmv2smv(Y,k);

% create overcomplete dictionary of sinusoids
F = 40; % refinement factor
A = zeros(M,M*F);
thetas = zeros(M*F,1);
for i = 0:M*F-1
    phi = pi*(1-2*i/(M*F));
    thetas(i+1) = acosd(phi/pi);
    A(:,i+1) = exp(1j*phi*(0:M-1));
end

tic
S1 = omp(e,A,k);
toc
eta = .5;
tic
S2 = bomp(e,A,k,eta);
toc
tic
S3 = bloomp(e,A,k,eta);
toc

thetas(S1)
thetas(S2)
thetas(S3)

% idxs = 2*pi*(0:M*F-1)/(M*F);
% acos(idxs(S1))

