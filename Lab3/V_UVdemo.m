%this script detects voice speecj in an utterance
%need a wave file called shout in current dir.
clear all; close all; clc;
[sp, fs] = audioread('Clean.wav'); %read the speech file
sp = sp(1:20000);
sp = sp/max(sp); % normalizing the speech the speech signal


%Segment speech into frames
fr_sz = 10/1000*fs; %frame size of 10ms
len = length(sp); %length of the speech
n_fr  = floor(len/fr_sz); %number of frames

beg = 1; enn = fr_sz; %initializing frames



for i = 1:n_fr,
    spf = sp(beg:enn);
    en(beg:enn) = sum(spf.^2)/fr_sz;
    beg = enn + 1; 
    enn = enn + fr_sz;
  
end
figure;
    plot(sp); hold on; plot(en, 'r');  
    title('Speech and scaled energy');
xlabel('Sample'); ylabel('Amplitude');
legend('Speech', 'energy');
grid;



