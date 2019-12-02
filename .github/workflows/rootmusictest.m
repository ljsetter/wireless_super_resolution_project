N = 100; % number of samples
M = 4; % number of array elements (lamda/2 spacing)
theta = deg2rad([80 100]'); % direction of arrival of signals
rho = eye(2); % correlation
snr = 20; % snr

Mag = [1 1];

Y = siggen(N, M, theta, rho, snr, Mag);

covmat = cov(Y');
rad2deg(musicdoa(covmat, length(theta), gridElements))
doaEst = rootmusicdoa(covmat, length(theta));