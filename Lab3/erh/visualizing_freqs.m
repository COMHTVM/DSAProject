clc;
clear;
close all;
clear plot;

zc_threshold = 0.100; % zero_crossings / num_samples
en_threshold = 0.075; % Energy threshold
silence_en_threshold = 0.03; % Silence energy threshold
fsize = 500;

sound_file = 'holum.wav';
[speech, fs] = audioread(sound_file);

[voiced, unvoiced, silence, t] = part_3(speech, fs, zc_threshold, ...
    en_threshold, silence_en_threshold, fsize);

% Part 5
% Removes NaN from the returned vectors to get voiced, unvoiced and
% silence in stand alone vectors
s_voiced = voiced(~isnan(voiced));
s_unvoiced = unvoiced(~isnan(unvoiced));
s_silence = silence(~isnan(silence));

% Listen to selections if you want
% soundsc(s_voiced, fs)
% soundsc(s_unvoiced, fs)
% soundsc(s_silence, fs)

N=1024;
frame_size = 500;

voiced_frame = s_voiced(1:frame_size);
X = abs(fft(voiced_frame,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
subplot(3,1,1);
plot(F,X);
xlabel('frequency (kHz)')
title('Approximate Spectrum of Voiced Speech with FFT');


unvoiced_frame = s_unvoiced(1:frame_size);
X = abs(fft(unvoiced_frame,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
subplot(3,1,2);
plot(F,X);
xlabel('frequency (kHz)')
title('Approximate Spectrum of Unvoiced Speech with FFT');


silence_frame = s_silence(1:frame_size);
X = abs(fft(silence_frame,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
subplot(3,1,3);
plot(F,X);
xlabel('frequency (kHz)')
title('Approximate Spectrum of Unvoiced Speech with FFT');