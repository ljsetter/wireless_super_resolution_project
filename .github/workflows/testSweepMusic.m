clear all
close all

N = 100; % number of samples
M = 8; % number of array elements (lamda/2 spacing)
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
trials = 100;
gridElements = 360;
for N = 10:100
    nn = N-9;
    Mag = [xmin xmax];
    success1 = 0;

    for j = 1:trials
        Y = siggen(N, M, theta, rho, snr, Mag);

        e = mmv2smv(Y,k);    
        covmat = cov(Y');        
        
        [~,idx,thetaGrid] = musicdoa(covmat, length(theta), gridElements);
        S1 = idx';

        success1 = CheckSuccess(success1, angle1, angle2, S1, rad2deg(thetaGrid));
        
    end
    prob1(nn) = success1/trials;
    
end

figure
plot(10:100,prob1);

title('Success probability vs. Number of Measurements when SNR = 30, 8 elements');
xlabel('Number of Measurements');
ylabel('Success rate in 100 trials');
hold off;

