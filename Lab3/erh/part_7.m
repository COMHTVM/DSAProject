function [voiced, unvoiced, silence, t] = part_7(speech, fs, N, f_size,...
   voiced_model, unvoiced_model, lim)
% Determines voiced, unvoiced, and silenced segments using the fft using
% predetermined frames within a signal.
% speech - recorded data
% fs - sample rate
% N - fft order
% f_size - frame size
% voiced_model - known fft of voiced speech
% unvoiced_model - known fft of unvoiced speech
    
    % Compute ffts for voiced and unvoiced models
    voiced_fft = abs(fft(voiced_model,N));
    voiced_fft = fftshift(voiced_fft);
    unvoiced_fft = abs(fft(unvoiced_model,N));
    unvoiced_fft = fftshift(unvoiced_fft);
    
    x = 1:length(speech);
    t = x./fs;

    len = length(speech);
    num_F = floor(len/(f_size));
    beg = 1;
    en = f_size;

    for i = 1:num_F
        speech_frame = speech(beg:en);

        % Compute fft for the frame
        X = abs(fft(speech_frame,N));
        X = fftshift(X);
        
        % Does this match unvoiced fft?
        if correlate_fft(X, voiced_fft) >= lim
            voiced_i(beg:en) = 1;
            unvoiced_i(beg:en) = 0;
            silence_i(beg:en) = 0;
        elseif correlate_fft(X, unvoiced_fft) >= lim
            voiced_i(beg:en) = 0;
            unvoiced_i(beg:en) = 1;
            silence_i(beg:en) = 0;
        else
            voiced_i(beg:en) = 0;
            unvoiced_i(beg:en) = 0;
            silence_i(beg:en) = 1;
        end

        % Increment
        beg = beg + f_size;
        en = en + f_size;
    end

    [voiced, v] = split_vectors(speech, voiced_i); 
    [unvoiced, v] = split_vectors(speech, unvoiced_i); 
    [silence, v] = split_vectors(speech, silence_i);
end