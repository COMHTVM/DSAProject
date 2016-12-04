
%
%This program looks at the fft of voiced and unvoiced portions of speech


%Reseting the Program
 clear all;
 close all;

%Reading the file
[speech, fs] = audioread('holum.wav');
%Converting the x axis from sample numbers to time
x = 1:length(speech);
t = x./fs;

%*******************************************************
%Plotting the file
%*******************************************************
figure;
plot(t, speech);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Waveform for a Male Speech Signal with a Sampling Frequency of 10KHZ');
axis([0 max(t) -1 1]);
%*******************************************************


%*******************************************************
%Displaying voiced and unvoiced speech segments
%*******************************************************
%Detecting voiced and unvoiced segments based on energy

%Computing the frame-by-frame energy of the signal
f_size = 128;
len = length(speech);
num_F = floor(len/(f_size));
beg =1;
en = f_size;
for i = 1:num_F
    speech_frame = speech(beg:en);
    theta = sum(abs(speech_frame))/length(speech_frame);
    energ(beg:en) = theta;
    beg = beg + f_size;
    en = en + f_size;
end           
energ(length(energ)+1:len) = energ(length(energ));

%Obtaining voiced and unvoiced segments based on energy
voiced_i = find(energ >= 0.075);
unvoiced_i = find((energ < 0.03)&(energ > 0.01));
v_speech = speech(voiced_i);
uv_speech = speech(unvoiced_i);

%Choosing the first 50ms of the detected voiced segment
speech_len = fs/1000*100;
voiced = v_speech(1:speech_len);
unvoiced = uv_speech(1:speech_len);

%Converting the x axis from sample numbers to time
x1 = 1:speech_len;
t1 = x1./fs;

%Plotting the chosen voiced and unvoiced speech segments
figure;
subplot(2,1,1);
plot(t1, voiced);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('A Voiced Segment from a Male Speech Signal');
axis([0 max(t1) -1 1]);
subplot(2,1,2);
N = 4096;
X = abs(fft(voiced,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
plot(F,X),
xlabel('frequency / f s')
grid;
title('Approximate Spectrum of a Voiced Speech segment with the FFT');

figure
subplot(2,1,1);
plot(t1, unvoiced);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('An Unvoiced Segment from a Male Speech Signal');
axis([0 max(t1) -1 1]);
subplot(2,1,2);
N = 4096;
X = abs(fft(unvoiced,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
plot(F,X),
xlabel('frequency / f s')
grid;
title('Approximate Spectrum of an unvoiced Speech with the FFT');
%*******************************************************


