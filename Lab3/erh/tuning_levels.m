% Script in which we determine appropriate levels by analyzing different
% recordings of voiced, unvoiced, and silenced speech.

% https://en.wikipedia.org/wiki/Voice_(phonetics)

clear;
close all;
clear plot;

fs = 500;

% Record voiced
%{
r = audiorecorder(fs,16,1); % Record at fs = 10000
recordblocking(r, 4);
audiowrite('voiced.wav', r.getaudiodata, fs); % Save data as .wav
%}


% Record unvoiced
%{
r = audiorecorder(fs,16,1); % Record at fs = 10000
recordblocking(r, 4);
audiowrite('unvoiced.wav', r.getaudiodata, fs); % Save data as .wav
%}


% Record silence
%{
r = audiorecorder(fs,16,1); % Record at fs = 10000
recordblocking(r, 4);
audiowrite('silence.wav', r.getaudiodata, fs); % Save data as .wav
%}

%
% Analyze data and tweak parametersclc;
zc_threshold = 0.135; % zero_crossings / num_samples
en_threshold = 0.075; % Energy threshold
silence_en_threshold = 0.02; % Silence energy threshold
fsize = 500;

% Voiced
sound_file = 'voiced.wav';
[speech, fs] = audioread(sound_file);
[voiced, unvoiced, silence, t] = part_3(speech, fs, zc_threshold, ...
    en_threshold, silence_en_threshold, fsize);
s_voiced = voiced(~isnan(voiced));

% Saved voiced segments
subplot(3,1,1);
plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
legend('voiced', 'unvoiced', 'silence')
title('Plot of Voiced/Unvoiced/Silence for Voiced Recording');
ylabel('Amp');
xlabel('time (s)');
hold on;

% Unvoiced
sound_file = 'unvoiced.wav';
[speech, fs] = audioread(sound_file);
[voiced, unvoiced, silence, t] = part_3(speech, fs, zc_threshold, ...
    en_threshold, silence_en_threshold, fsize);

% Saved unvoiced segments
s_unvoiced = unvoiced(~isnan(unvoiced));
subplot(3,1,2);
plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
title('Plot of Voiced/Unvoiced/Silence for Unvoiced Recording');
ylabel('Amp');
xlabel('time (s)');
hold on;

% Silence
sound_file = 'silence.wav';
[speech, fs] = audioread(sound_file);
[voiced, unvoiced, silence, t] = part_3(speech, fs, zc_threshold, ...
    en_threshold, silence_en_threshold, fsize);

s_silence = silence(~isnan(silence));
subplot(3,1,3);
plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
title('Plot of Voiced/Unvoiced/Silence for Silence Recording');
ylabel('Amp');
xlabel('time (s)');
hold on;

pause;

% Create plots for individual frames
clear plot;
close all;

frame_size = 500;
x = 1:frame_size;
t = x./frame_size;

voiced_frame = s_voiced(1:frame_size);
subplot(3,1,1);
plot(t, voiced_frame);
xlabel('time (s)')
ylabel('Amp')
title('One Frame of Voiced Speech');

unvoiced_frame = s_unvoiced(1:frame_size);
subplot(3,1,2);
plot(t, unvoiced_frame);
xlabel('time (s)')
ylabel('Amp')
title('One Frame of Unvoiced Speech');

silence_frame = s_silence(1:frame_size);
subplot(3,1,3);
plot(t, silence_frame);
xlabel('time (s)')
ylabel('Amp')
title('One Frame of Silenced Speech');