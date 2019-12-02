%%
close all; clearvars; clc
cvx_solver sdpt3
signal_importer
N = length(X1);

%%
covmat1 = cov(X1);
N1 = 1;
tic
rad2deg(musicdoa(covmat1, N1, N))
toc
tic
rad2deg(rootmusicdoa(covmat1, N1))
toc

%%
covmat2 = cov(X2);
N2 = 2;
tic
rad2deg(musicdoa(covmat2, N2, N))
toc
rad2deg(rootmusicdoa(covmat2, N2))
toc

%%
% d = 0.5;
% lambda = 1;
% y = zeros(1,4);
% for ii = 1:N
%     y = y + 0
% end

%%
N = 100;
M = 4;
theta = deg2rad(80);
rho = 1;
snr = inf;

Y = siggen(N, M, theta, rho, snr);

covmat = cov(Y');
rad2deg(musicdoa(covmat, length(theta), N))
% [S,W] = pmusic(covmat, length(theta), 'corr');
[S,W] = pmusic(Y', length(theta));
[~,I] = max(S);
rad2deg(W(I))

% rad2deg(rootmusicdoa(covmat, length(theta)))

%%