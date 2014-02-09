function [ result ] = B(j, yiminus1, yi)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS
    
    section = mod(j, (NUM_LABEL_TAGS ^ 2)) + 1;
    prev_tag = ceil(section / NUM_LABEL_TAGS);
    current_tag = mod(section, NUM_LABEL_TAGS) + 1;

    if yiminus1 == prev_tag && yi == current_tag
        result = 1;
    else
        result = 0;
    end;
    
end

