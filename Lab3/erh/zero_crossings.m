function num_crossings = zero_crossings(xx)
% Count and return the number of 0 crossings in the vector, xx.

num_crossings = 0;
for i = 1:length(xx) - 1
    num_crossings = num_crossings + abs(.5 * sign(xx(i)) - .5 * sign(xx(i+1)));
end