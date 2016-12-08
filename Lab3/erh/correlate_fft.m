function match = correlate_fft(f1, f2)
% Uses correlation function to diff two ffts
    cor = corrcoef(f1, f2);
    match = cor(1,2);
end