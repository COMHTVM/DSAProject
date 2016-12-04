clear all, close all, clc;
n = [0:149];
x1 = randn(150,1);
N = 2048;
X = abs(fft(x1,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
plot(F,X),
xlabel('frequency / f s')
grid;
title('Approximate Spectrum of a Sinusoid with the FFT');