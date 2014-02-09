function [ result ] = A(j, xbar, i)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS FEATURE_TAGS LABEL_TAGS ...
        POS_TRAINING_SENTENCES POS_TRAINING_LABELS ...
        POS_VALIDATION_SENTENCES POS_VALIDATION_LABELS ...
        POS_TEST_SENTENCES POS_TEST_LABELS ...
        AUXILIARY_TRAINING    
    feature = ceil(j / (NUM_LABEL_TAGS ^ 2));
    current_feature = xbar(i); % Need some way of loading tag data for xbar(i)
    if feature == current_feature
        result = 1;
    else
        result = 0;
    end;
end

