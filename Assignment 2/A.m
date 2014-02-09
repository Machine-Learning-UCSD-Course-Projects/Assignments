function [ result ] = A(j, xbar, i)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS
    tag = ceil(j / NUM_FEATURE_TAGS);
    current_tag = 0; % Need some way of loading tagdata for xbar(i)
    % @KASHYAP, delete the line below and uncomment following lines 
    % when you are actually running the code.
    result = 1;
%     if feature == current_feature
%         result = 1;
%     else
%         result = 0;
%     end;
end

