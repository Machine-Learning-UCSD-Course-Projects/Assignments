function [ result ] = A(j, xbar, i)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_LABEL_TAGS
    feature = ceil(j / (NUM_LABEL_TAGS ^ 2));
    current_feature = xbar(i); % Need some way of loading tag data for xbar(i)
    if feature == current_feature
        result = 1;
    else
        result = 0;
    end;
end

