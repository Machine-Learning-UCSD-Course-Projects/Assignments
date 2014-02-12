function [ result ] = A(j, xbar, i)
    %global NUM_LABEL_TAGS_SQUARE;
    %feature = j;%ceil(j / NUM_LABEL_TAGS_SQUARE);
    
    %current_feature = xbar(i); % Need some way of loading tag data for xbar(i)
    result = (j == xbar(i));
end

function result = checkInterrogative(xbar)
    if ismember([32,33,34,35],xbar(1))
        result = 1;
    else
        result = 0;
    end
end

function result = checkAdverbs(xbar)
    if ismember([20,21,22],xbar(1))
        result = 1;
    else
        result = 0;
    end
end

function result = checkAuxiliary(xbar)
    if xbar(1) == 36
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
