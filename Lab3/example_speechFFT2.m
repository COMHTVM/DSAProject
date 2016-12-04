
%
%This program looks at the fft of voiced and unvoiced portions of speech


%Reseting the Program
 clear all;
 close all;
 clc;

%Reading the file
[speech, fs] = audioread('Clean.wav');
speech1 = AddNoise(speech, 5);
%Converting the x axis from sample numbers to time
x = 1:length(speech);
t = x./fs;

%*******************************************************
%Plotting the file
%*******************************************************
figure;
subplot(2,1,1);
plot(t, speech);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Waveform for a Male Speech Signal with a Sampling Frequenvy of 16KHZ');
axis([0 max(t) -1 1]);
subplot(2,1,2);
plot(t, speech1);
xlabel('Time (seconds)');
ylabel('Amplitude');
axis([0 max(t) -1 1]);
%*******************************************************


%*******************************************************
%Displaying voiced and unvoiced speech segments
%*******************************************************
%Detecting voiced and unvoiced segments based on energy

%Computing the frame-by-frame energy of the signal
f_size = 1000;
len = length(speech);
num_F = floor(len/(f_size));
beg =1;
en = f_size;
for i = 1:num_F
    speech_frame = speech(beg:en);
    speech_frame1 = speech1(beg:en);
    theta = sum(abs(speech_frame))/length(speech_frame);
    energ(beg:en) = theta;
    beg = beg + f_size;
    en = en + f_size;
end
    figure;
subplot(2,2,1);
plot(speech_frame);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('One frame from a Male Speech Signal');
subplot(2,2,2);
plot(speech_frame1);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('One frame from a Noisy Male Speech Signal');
subplot(2,2,3);
N = 1028;
X = abs(fft(speech_frame,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
plot(F,X),
xlabel('frequency / f s')
grid;
title('Approximate Spectrum of a speech frame with the FFT');
subplot(2,2,4);
N = 1028;
X = abs(fft(speech_frame1,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
plot(F,X),
xlabel('frequency / f s')
grid;
title('Approximate Spectrum of a Noisy speech frame with the FFT');
pause

           


