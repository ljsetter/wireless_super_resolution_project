clear all
close all

N = 100; % number of samples
M = 32; % number of array elements (lamda/2 spacing)
angle1 = 23;
angle2 = 74;
theta = deg2rad([angle1 angle2]'); % direction of arrival of signals
xmin = 1;
xmax = 1;
Mag = [xmin xmax];
rho = 0; % correlation
snr = 30; % snr
k = length(theta);
success1 = 0;
success2 = 0;
success3 = 0;
success4 = 0;
trials = 100;
gridElements = 360;
for xmax = 1:20
    nn = xmax;
    Mag = [xmin xmax];
    success1 = 0;
    success2 = 0;
    success3 = 0;
    success4 = 0;
    for j = 1:trials
        Y = siggen(N, M, theta, rho, snr, Mag);

        e = mmv2smv(Y,k);    
        covmat = cov(Y');
        
        % create overcomplete dictionary of sinusoids
        F = 20; % refinement factor
        A = zeros(M,M*F);
        thetas = zeros(M*F,1);
        for i = 0:M*F-1
            phi = pi*(1-2*i/(M*F));
            thetas(i+1) = acosd(phi/pi);
            A(:,i+1) = exp(1j*phi*(0:M-1));
        end    
        
        S1 = omp(e,A,k);      
        eta = 0.1;      
        S2 = bomp(e,A,k,eta);               
        S3 = bloomp(e,A,k,eta);
        [~,idx,thetaGrid] = musicdoa(covmat, length(theta), gridElements);
        S4 = idx';
            
        success1 = CheckSuccess(success1, angle1, angle2, S1, thetas);
        success2 = CheckSuccess(success2, angle1, angle2, S2, thetas);
        success3 = CheckSuccess(success3, angle1, angle2, S3, thetas);
        success4 = CheckSuccess(success4, angle1, angle2, S4, rad2deg(thetaGrid));
        
    end
    prob1(nn) = success1/trials;
    prob2(nn) = success2/trials;
    prob3(nn) = success3/trials;
    prob4(nn) = success4/trials;
  
end

figure
hold on;
plot(prob1);
hold on;
plot(prob2);
hold on;
plot(prob3);
hold on;
plot(prob4);

legend('OMP', 'BOMP', 'BLOOMP', 'MUSIC');
title('Success probability vs. dynamic range when SNR = 30dB, 32 elements');
xlabel('Dynamic range');
ylabel('Success rate in 100 trials');
hold off;

% idxs = 2*pi*(0:M*F-1)/(M*F);
% acos(idxs(S1))
