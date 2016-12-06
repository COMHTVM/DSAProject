function [xx, yy] = split_vectors(values, indexes)
% split_vectors separates values into 2 vectors of length values.
% xx[i] == values[i] when index[i] == 1, 0 o/w
% yy[y] == values[i] when index[i] == 0, 0 o/w
xx = values;
yy = values;

for i=1:length(indexes)
    if indexes(i)
        yy(i) = NaN;
    else
        xx(i) = NaN;
    end
end
end