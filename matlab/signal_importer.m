% Import data:
data = csvread('1_transmitter.csv');

% Populate the signal matrix:
X = zeros(size(data,1),size(data,2)/2);
for i = 1:size(data,2)/2
    X(:,i) = data(:,2*i-1) + 1i*data(:,2*i);
end