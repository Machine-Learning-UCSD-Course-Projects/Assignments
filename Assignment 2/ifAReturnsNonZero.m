function [ result ] = ifAReturnsNonZero(j, xbar)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    global NUM_LABEL_TAGS
    current_feature = ceil(j / (NUM_LABEL_TAGS ^ 2));
    result = 1;
    if current_feature > 36
        result = 1;
        return;
    end;
    for i = 1:size(xbar, 2)
        if current_feature == xbar(i)
            result = 1;
            return;
        end;
    end;
end

