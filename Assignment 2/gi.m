function sum = gi(yiminus1, yi, xbar, i, numFF, w)
%ff : array of feature functions
%w  : array of weights
%The equation below equation 4 in the notes
    sum = 0;
    for j = 1 : numFF
        a = A(j, xbar, i);
        if a ~= 0
            sum = sum + w(j) * a * B(j, yiminus1, yi);
        end
    end
end