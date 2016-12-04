clear all; close all; clc
%How to view the spectrum of a signal using FFT in Matlab
t = [0:255]; %time vector
y = cos(2*pi*t/50); %given signal
figure;
plot(y);
xlabel('time'); ylabel('amplitude');
grid;
title('Approximate Spectrum of a Sinusoid with the FFT');
N = 2048; %# of fft points (or frequency pints)
Yf = abs(fft(y,N)); %Computing the N-point fft
Yf = fftshift(Yf); %shift the zero-frequency component to center of spectrum
f = [-N/2:N/2-1]/N;%the x axis which is the normalized frequency

figure
plot(f, Yf),
xlabel('frequency / fs')
grid;
title('Approximate Spectrum of a Sinusoid with the FFT');