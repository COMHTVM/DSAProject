function nsp = AddNoise(sp, snr);
%AddNoise.m created by Dr. Uche Abanulo; %Spring 2009
%inputs: 
%sp = Speech
%SNR = signal to noise ratio in decibels (dB)
%
%output:
%nsp = noisy speech with a signal to noise ratio of SNR dB 

% Generate Additive White Guassian Noise (AWGN) - zero mean and unity variance)
len = length(sp);
ns = randn(1, len); % generating the noise signal
ns = (ns - mean(ns))/std(ns);%standardizing the signal

%Scale noise 
sc_ns = (ns*max(sp))./(max(ns)*(10^(snr/10)));

%Generate Noisy speech
nsp = [sp + sc_ns'];