function [x] = anmdoa(y, d, lambda)
M = length(y);
% solve dual problem with cvx
cvx_begin sdp
    variable S(M + 1, M + 1) hermitian
    S = 0;
    S(M+1, M+1) == 1;
    trace(S) == 2;
    for j = 1:M-1
        sum(diag(S,j)) == S(M+1-j, M+1);
    end
    maximize(real(S(1:M, M+1)' * y))
cvx_end
c = S(1:M, M+1);

% find roots of P
r = conv(c, flipud(conj(c)));
r(M) = 1 - r(M);
roots_P = roots(r);

% isolate roots on the unit circle
tol = 1e-2;
roots_uc = roots_P(abs(1-abs(roots_P)) < tol);
[~, idx] = sort(real(roots_uc));
roots_uc = roots_uc(idx);
t = angle(roots_uc(1:2:end))/(2*pi*d/lambda);

% amplitude estimation
A_T = exp(1j*2*pi*d/lambda * (0:(M-1))' * t');
x = A_T\y;