function [voiced, unvoiced, silence, t] = part_3(speech, fs, ...
    zc_threshold, en_threshold, silence_en_threshold, f_size)
% This computes voiced, unvoiced, and silence arrays passed in through the
% Specified limits
    %{
    Following:
    https://www.asee.org/documents/zones/zone1/2008/student/ASEE12008_0044_paper.pdf
    %}

    x = 1:length(speech);
    t = x./fs;

    len = length(speech);
    num_F = floor(len/(f_size));
    beg = 1;
    en = f_size;

    for i = 1:num_F
        speech_frame = speech(beg:en);

        % Compute zero crossings and energy for the frame
        zc = zero_crossings(speech_frame);
        theta = sum(abs(speech_frame))/length(speech_frame);
        energy(beg:en) = theta;
        crossing(beg:en) = zc;

        % Check for zc threshold
        ts = zc/f_size <= zc_threshold;
        es = theta >= en_threshold;
        voiced_i(beg:en) = (ts && es);

        % 'Silence' is low energy
        silence_i(beg:en) = theta < silence_en_threshold;

        % Check for energy threshold
        beg = beg + f_size;
        en = en + f_size;
    end

    [voiced, unvoiced] = split_vectors(speech, voiced_i); 
    [silence, unvoiced] = split_vectors(unvoiced, silence_i);

end