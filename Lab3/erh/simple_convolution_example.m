clear;
clc;

x = [1 2 3 0 1 -3 4 1];
B = [.25 .25 .25 .25];

padded_x = [x zeros(1, length(B)-1)];
n = 0:(length(x) + length(B) - 2);
y = filter(B, 1, padded_x); % Does the convolution

stem(n, y);
xlabel('output values');
ylabel('input values');