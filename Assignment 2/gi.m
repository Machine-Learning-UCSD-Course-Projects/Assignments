function sum = gi(yiminus1, yi, xbar, i, numFF, w)
%ff : array of feature functions
%w  : array of weights
%The equation below equation 4 in the notes
    sum = 0;
    for j = 1 : numFF % numel()
        %sum = sum + w(j)* featureFunctions{j}(yiminus1, yi, xbar, i);
        sum = sum + w(j)* computeFeatureFunction(j, yiminus1, yi, xbar, i);
    end