% Import data:
data1 = csvread('../data/1_transmitter.csv');
data2 = csvread('../data/2_transmitters.csv');

% Populate the signal matrix:
X1 = zeros(size(data1,1),size(data1,2)/2);
for i = 1:size(data1,2)/2
    X1(:,i) = data1(:,2*i-1) + 1i*data1(:,2*i);
end
X2 = zeros(size(data2,1),size(data2,2)/2);
for i = 1:size(data2,2)/2
    X2(:,i) = data2(:,2*i-1) + 1i*data2(:,2*i);
end