function sum = gi(yiminus1, yi, xbar, i, numFF, w)
%ff : array of feature functions
%w  : array of weights
%The equation below equation 4 in the notes
    sum = 0;
    for j = 1 : numFF
        feature = ceil(j / NUM_LABEL_TAGS_SQUARE)
        %a = A(j, xbar, i);
        %if a ~= 0
        if feature == xbar(i)
            sum = sum + w(j) * B(j, yiminus1, yi); % * a
        end
    end
end