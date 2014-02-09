function [ num ] = numFeatureFunctions()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS
    num = NUM_FEATURE_TAGS * (NUM_LABEL_TAGS ^ 2);
end

