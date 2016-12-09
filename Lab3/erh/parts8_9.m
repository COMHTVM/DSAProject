% Part 8 - Filtering
clc;
clear;
close all;
clear plot;

sound_file = 'noisy_speech.wav';
[nsp, fs] = audioread(sound_file);

N = length(nsp);
x = 1:length(nsp);
t = x./fs;

% Moving average filter
order = 10;
df = (1/order)*ones(1,order);
A = 1;
y1 = filter(df, A, nsp);

% Basic low pass filter fir
df = designfilt('lowpassfir','DesignMethod', ...
      'window','FilterOrder',10,'CutoffFrequency', .05);
y2 = filter(df, nsp); % Apply filter to speech
B = df.Coefficients;

% Passband filter centered around speech 
[df, A] = fir1(10,[0.001 .1]);
y3 = filter(df, A, nsp); % Apply filter to speech


% Savitzky-Golay filtering
y4 = sgolayfilt(nsp, 3, 11);

% Make plots of filtered signals
subplot(5,1,1);
plot(t, nsp);
title('Original Noisy Recording');
grid;
xlabel('time (s)');
ylabel('Amp');

subplot(5,1,2);
plot(t,y1);
title('Moving Average Filter');
grid;
xlabel('time (s)');
ylabel('Amp');

subplot(5,1,3);
plot(t,y2);
title('Basic Low Pass FIR');
grid;
xlabel('time (s)');
ylabel('Amp');

subplot(5,1,4);
plot(t,y3);
title('Basic Band Pass FIR');
grid;
xlabel('time (s)');
ylabel('Amp');

subplot(5,1,5);
plot(t,y4);
title('Savitzky-Golay');
grid;
xlabel('time (s)');
ylabel('Amp');

% audiowrite('MAF.wav', y1, fs);
% audiowrite('LPF.wav', y2, fs);
% audiowrite('BPF.wav', y3, fs);
% audiowrite('SGF.wav', y4, fs);

pause
% Part 9

zc_threshold = 0.100; % zero_crossings / num_samples
en_threshold = 0.075; % Energy threshold
silence_en_threshold = 0.05; % Silence energy threshold
fsize = 500;

[voiced, unvoiced, silence, t] = part_3(nsp, fs, zc_threshold,  ...
    en_threshold, silence_en_threshold, fsize);

subplot(5,1,1);plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
title('Voiced/Unvoiced/Silence Identification');
xlabel('time (s)');
ylabel('Amp');


[voiced, unvoiced, silence, t] = part_3(y1, fs, zc_threshold,  ...
    en_threshold, silence_en_threshold, fsize);

subplot(5,1,2);plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
xlabel('time (s)');
ylabel('Amp');


[voiced, unvoiced, silence, t] = part_3(y2, fs, zc_threshold,  ...
    en_threshold, silence_en_threshold, fsize);

subplot(5,1,3);plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
xlabel('time (s)');
ylabel('Amp');


[voiced, unvoiced, silence, t] = part_3(y3, fs, zc_threshold,  ...
    en_threshold, silence_en_threshold, fsize);

subplot(5,1,4);plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
xlabel('time (s)');
ylabel('Amp');

[voiced, unvoiced, silence, t] = part_3(y4, fs, zc_threshold,  ...
    en_threshold, silence_en_threshold, fsize);

subplot(5,1,5);plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
xlabel('time (s)');
ylabel('Amp');
