function [snapshots] = siggen(N, M , theta, rho, snr)
% returns synthetic array data for a half wavelength spacing ULA

% N: number of samples
% M: number of elements
% theta: directions of arrival
% rho: correlation matrix
% snr: receiver SNR

% the data carried by a PSKM signal
signals = exp(1j*2*pi*rand(length(theta),N)-pi);
signals = chol(rho)*signals;

% steering vectors
V = exp(-1j*pi*(0:M-1)'*cos(theta)');
snapshots = V*signals;
snapshots = awgn(snapshots, snr);