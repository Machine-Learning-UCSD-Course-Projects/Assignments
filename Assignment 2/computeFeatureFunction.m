function [ result ] = computeFeatureFunction(j, yiminus1, yi, xbar, i)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    result = A(j, xbar, i) * B(j, yiminus1, yi);
end

