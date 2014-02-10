function [ result ] = A(j, xbar, i)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS FEATURE_TAGS LABEL_TAGS ...
        POS_TRAINING_SENTENCES POS_TRAINING_LABELS ...
        POS_VALIDATION_SENTENCES POS_VALIDATION_LABELS ...
        POS_TEST_SENTENCES POS_TEST_LABELS ...
        AUXILIARY_TRAINING    
%    feature = ceil(j / (NUM_LABEL_TAGS ^ 2));
%    current_feature = xbar(i); % Need some way of loading tag data for xbar(i)
    
    switch j
        case 1
             % POS tagged sentence starting with Wh-word
             result = checkInterrogative(xbar,i);
        case 2
             % POS tagged sentence starting with adverbs
             result = checkAdverbs(xbar,i);
        case 3
             % Sentence starting with auxiliary verb
             result = checkAuxiliary(xbar,i);
        case 4
            % Return for a period
            result = checkPeriod(xbar,i);             
        otherwise
            % Do something??
            result = 1
    end
%             
%     if feature == current_feature
%         result = 1;
%     else
%         result = 0;
%     end;
end

function result = checkInterrogative(xbar,i)
    if ismember([32,33,34,35],xbar(1))
        result = 1;
    else
        result = 0;
    end
end

function result = checkAdverbs(xbar,i)
    if ismember([20,21,22],xbar(1))
        result = 1;
    else
        result = 0;
    end
end

function result = checkAuxiliary(xbar,i)
    if xbar(1) == 1
        result = 1;
    else
        result = 0;
    end
end

function result = checkPeriod(xbar,i)
    if numel(xbar) == i
        result = 1;
    else
        result = 0;
    end
end
