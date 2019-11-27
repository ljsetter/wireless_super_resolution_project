close all; clearvars; clc;
gridElements = 400;
numElements = 4;

thetaGrid = linspace(0,pi,gridElements);
v = [];
for i = 1:numel(thetaGrid)
    v = [v exp(-1j*pi*(0:numElements-1)'*cos(thetaGrid(i)))];
end

plot(abs(fft(v(:,001:200))))

