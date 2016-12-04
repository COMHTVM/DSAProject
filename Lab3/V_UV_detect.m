%this script detects voice speecj in an utterance
%need a wave file called shout in current dir.
clear all; close all; clc;
[sp, fs] = wavread('Clean'); %reqad the speech file
sp = sp(1:20000);
sp = sp/max(sp); % normalizing the speech the speech signal
 sp = AddNoise(sp, 5);

%Segment speech into frames
fr_sz = floor(10/1000*fs); %frame size of 10ms
len = length(sp); %length of the speech
n_fr  = floor(len/fr_sz); %number of frames

beg = 1; enn = fr_sz; %initializing frames

% sil_thresh = .0005;
% uv_thresh = .005;
sil_thresh = .005;
uv_thresh = .05;

for i = 1:n_fr,
    spf = sp(beg:enn);
    en = sum(spf.^2)/fr_sz;
    if en <= sil_thresh, 
        mrkr(beg:enn) = 0;%marker for silence
    elseif en <=uv_thresh,
        mrkr(beg:enn) = 0.5; %marker for unvoiced
    else
        mrkr(beg:enn) = 1; %marker for voiced
    end
    
    beg = enn + 1; 
    enn = enn + fr_sz;

end




figure;
 plot(sp); hold on; plot(mrkr, 'r');  
    title('Speech and scaled energy: 0 = sil: 0.5 = UV: 1 = voiced');
xlabel('Sample'); ylabel('Amplitude');
legend('Speech', 'marker');
grid;

sil_ind = find(mrkr == 0);
uv_ind = find(mrkr == 0.5);
v_ind =find(mrkr == 1);
pause
soundsc(sp(v_ind), fs);
