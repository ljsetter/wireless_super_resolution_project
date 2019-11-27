function [snapshots] = siggen(N, M , theta, rho, snr)
% returns synthetic array data for a half wavelength spacing ULA

% N: number of samples
% M: number of elements
% theta: directions of arrival
% rho: correlation between signals
% snr: receiver SNR

% the data carried by a PSKM signal
k = length(theta);
signals = exp(1j*2*pi*rand(k,N)-pi);
if rho == 1
   signals = repmat(signals(1,:),k,1);
else
    % covariance matrix
    R = ones(k)*rho+eye(k)*(1-rho);
    L = chol(R);
    signals = (signals.'*L).';
end

% steering vectors
V = exp(-1j*pi*(0:M-1)'*cos(theta)');
snapshots = V*signals;
snapshots = awgn(snapshots, snr);