function [ result ] = B(j, prev_tag, current_tag, yiminus1, yi)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS NUM_LABEL_TAGS_SQUARE
    
    %feature = ceil(j / NUM_LABEL_TAGS_SQUARE);
%     section = mod(j, NUM_LABEL_TAGS_SQUARE);
%     if section == 0
%         section = (NUM_LABEL_TAGS_SQUARE);
%     end;
%     prev_tag = ceil(section / NUM_LABEL_TAGS);
%     current_tag = mod(section, NUM_LABEL_TAGS);
%     if current_tag == 0
% 		current_tag = NUM_LABEL_TAGS;
%     end
        
        result = (yiminus1 == prev_tag && yi == current_tag);
end

function result = checkInterrogative(yiminus1,yi)
    if yiminus1==7 && yi==4
        result = 1;
    else
        result = 0;
    end
end

function result = checkAdverbs(yiminus1,yi)
    if yiminus1 == 2 && yi==7
        result = 1;
    else
        result = 0;
    end
end

function result = checkAuxiliary(yiminus1,yi)
    if yiminus1==7 && yi==4
        result = 1;
    else
        result = 0;
    end
end

function result = checkPeriod(yiminus1,yi)
    if yi==3
        result = 1;
    else
        result = 0;
    end
end

