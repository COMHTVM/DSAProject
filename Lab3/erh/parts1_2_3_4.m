% Part 1, use recordings 
clc;
clear;
close all;
clear plot;

% Make recordings, commented out since we using existing files
%{
% Part 1 record sounds
fs = 10000;
r = audiorecorder(fs,16,1); % Record at fs = 10000
recordblocking(r, 8);
audiowrite('holum.wav', r.getaudiodata, fs); % Save data as .wav

% Part 2, read in sound data
[sp, fs] = audioread('holum.wav');
plot(sp);

% Part 4
% Add noise and save it as a new recording
[sp, fs] = audioread('holum.wav');
noisy = AddNoise(sp, 5);

% audiowrite('noisy_speech.wav', noisy, fs); % Save data as .wav
[nsp, nfs] = audioread('noisy_speech.wav');
plot(nsp);
%}

zc_threshold = 0.100; % zero_crossings / num_samples
en_threshold = 0.075; % Energy threshold
silence_en_threshold = 0.03; % Silence energy threshold
fsize = 1000;

%
% Identify voiced, unvoiced, and silence from basic recording
%
sound_file = 'holum.wav';
[speech, fs] = audioread(sound_file);

[voiced, unvoiced, silence, t] = part_3(speech, fs, zc_threshold, ...
    en_threshold, silence_en_threshold, fsize);

hold off;
subplot(4,1,1);
plot(t, speech);
title('Plot of Standard Recording');
ylabel('Amp');
xlabel('time (s)');

subplot(4,1,2);
plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
legend('voiced', 'unvoiced', 'silence')
title('Plot of Voiced/Unvoiced/Silence for Standard Recording');
ylabel('Amp');
xlabel('time (s)');
hold on;

%
% Try 5db of noise to recording and repeat part 3.
%
sound_file = 'noisy_speech.wav';
[nsp, fs] = audioread(sound_file);

[voiced, unvoiced, silence, t] = part_3(nsp, fs, zc_threshold, ...
    en_threshold, silence_en_threshold, fsize);

subplot(4,1,3);
plot(t, nsp);
title('Plot of Noisy Recording');
ylabel('Amp');
xlabel('time (s)');

subplot(4,1,4);
plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
legend('voiced', 'unvoiced', 'silence')
title('Plot of Voiced/Unvoiced/Silence for Noisy Recording');
ylabel('Amp');
xlabel('time (s)');