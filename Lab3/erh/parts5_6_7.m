clc;
clear;
close all;
clear plot;

sound_file = 'noisy_speech.wav';
[nsp, fs] = audioread(sound_file);

sound_file = 'holum.wav';
[speech, fs1] = audioread(sound_file);

% Unvoiced segments determined in the previous section
seg1 = nsp(31001:31500);
seg2 = nsp(31501:32000);
seg3 = nsp(32001:32500);

seg4 = nsp(48001:48500);
seg5 = nsp(48501:49000);
seg6 = nsp(49001:49500);

N = 1024;

% display ffts for unvoiced segments (only doing 3, they all look basically
% the same.
subplot(2,1,1)
for s=[seg1 seg2 seg3]
    X = abs(fft(s,N));
    X = fftshift(X);
    F = [-N/2:N/2-1]/N;
    plot(F,X);
    hold on
end
xlabel('frequency / f s');
legend('seg1', 'seg2', 'seg3');
grid
title('ffts for first segment');

subplot(2,1,2)
for s=[seg4 seg5 seg6]
    X = abs(fft(s,N));
    X = fftshift(X);
    F = [-N/2:N/2-1]/N;
    plot(F,X);
    hold on
end
xlabel('frequency / f s');
legend('seg4', 'seg5', 'seg6');
grid
title('ffts for second segment');

pause


% Plot comparisons of voiced, unvoiced, and silence ffts
hold off;
seg = nsp(46001:46500);
X = abs(fft(seg,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
plot(F,X);
hold on

X = abs(fft(seg1,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
plot(F,X);
hold on
    
seg = nsp(25001:25500);
X = abs(fft(seg,N));
X = fftshift(X);
F = [-N/2:N/2-1]/N;
plot(F,X);

grid;
title('Comparison of Voiced, Unvoiced, and Noise ffts');
legend('voiced', 'unvoiced', 'noise');

pause;


% Find the 'high' coefficient indecies in the fft

% Based on the above information, do something with part 7 to identify
% voiced/etc
%
voiced_model = nsp(46001:46500);
unvoiced_model = nsp(31001:31500);

% regular
[voiced, unvoiced, silence, t] = part_7(speech, fs, N, 500, ...
    voiced_model, unvoiced_model, .4);
subplot(2,1,1);
plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
legend('voiced', 'unvoiced', 'silence')
title('Identification using FFT on Standard Recording');
ylabel('Amp');
xlabel('time (s)');
grid;
hold on;

% noisy
[voiced, unvoiced, silence, t] = part_7(nsp, fs, N, 500, ...
    voiced_model, unvoiced_model, .4);
subplot(2,1,2);
plot(t, voiced, 'b');
hold on;
plot(t, unvoiced, 'r');
plot(t, silence, 'g');
legend('voiced', 'unvoiced', 'silence')
title('Identification using FFT on Standard Recording');
ylabel('Amp');
xlabel('time (s)');
grid;
hold on;

