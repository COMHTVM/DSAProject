function match = compare_fft_hi_freqs(f1, f2, num, lim)
% Finds the highest num valued indexes between the arrays f1, f2. If more
% than lim of them match then the ffts are 'equivalent'

    [val1, index1] = sort(f1, 'descend');
    [val2, index2] = sort(f2, 'descend');

    index1=index1(1:num);
    index2=index2(1:num);

    s = intersect(index1, index2);

    match = length(s) >= lim;

end