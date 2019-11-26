clear all
close all

N = 32;
P = 128;
D = randn(N,P);

% Create sparse weights
alpha = zeros(P,1);
alpha(5) = 2;   
alpha(13) = 1;
alpha(17) = 3;
alpha(21) = 4;
alpha(32) = 1;

f = D*alpha;
Ro = f;
lambda = [];

signal = D'*Ro;
pk = find(abs(signal) == max(abs(signal(:)))); % Find index of max value

lambda = [lambda pk];
phi = D(:,pk);
uk(:,1) = phi;

f_new = zeros(N,1) + (dot(Ro,uk)/norm(uk)^2)*uk; % 0th iteration of estimated signal
R_new = f - f_new; % Error

k = 1;
for n = 1:3
    signal = D'*R_new;
    pk = find(abs(signal) == max(abs(signal(:)))); % Find index of max value
    lambda = [lambda pk];
    sum = zeros(N,1);
    phi = D(:,pk);
    for j = 1:k
        sum = sum + (dot(phi,uk(:,j))/norm(uk(:,j))^2)*uk(:,j);
    end
    
    uk(:,k+1) = phi-sum;
    f_new = f_new + (dot(R_new,uk(:,k+1)/norm(uk(:,k+1))^2)*uk(:,k+1)); % New estimation of signal
    R_new = f - f_new; % Error
    k = k+1;
end

plot(f);
hold on;
plot(f_new);
legend('f','f_{estimate}');
disp(norm(R_new));

omp(f,D,5)
% function [x] = omp(K,y,A)
% N = size(A,2);
% x = zeros(1,N);
% R = y;
% u = zeros(N,K);
% 
% 
% % choose first atom
% [~,pk] = max(A'*R);
% uk = A(:,pk);
% uk = uk/norm(uk);
% u(:,1) = uk;
% % compute approximation and residual
% x = x+(R'*uk)*uk;
% R = f-x;
% 
% if K > 1
%     for k = 1:K-1
%         % choose next atom
%         [~,pk] = max(Phi'*R);
%         % orthogonalize new atom w.r.t. previous atoms
%         uk = (eye(N)-u*u')*A(:,pk);
%         uk = uk/norm(uk);
%         u = [u uk];
%         % compute approximation and residual
%         x = x+(R'*uk)*uk;
%         R = R-(R'*uk)*uk;
%     end
% end
% end