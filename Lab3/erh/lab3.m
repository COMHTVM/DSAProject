%{
fs = 10000;
r = audiorecorder(fs,16,1); % Record at fs = 10000
recordblocking(r, 8);
audiowrite('holum.wav', r.getaudiodata, fs); % Save data as .wav
%}

%
% Part 2, read in sound data
[sp, fs] = audioread('holum.wav');
plot(sp);
%}

% Part 4
% Add noise and save it as a new recording
[sp, fs] = audioread('holum.wav');
noisy = AddNoise(sp, 5);

% audiowrite('noisy_speech.wav', noisy, fs); % Save data as .wav
[nsp, nfs] = audioread('noisy_speech.wav');
plot(nsp);