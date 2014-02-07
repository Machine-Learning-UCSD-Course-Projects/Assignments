function sum = gi(yiminus1, yi, xbar, i, ff, w)
%ff : array of feature functions
%w  : array of weights
%The equation below equation 4 in the notes
    sum = 0;
    for i = 1 : numel(ff)
        sum = sum + w(i)* ff{i}(yiminus1, yi, xbar, i);
    end