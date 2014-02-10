function [ result ] = A(j, xbar, i)
    global NUM_LABEL_TAGS   
    feature = ceil(j / (NUM_LABEL_TAGS ^ 2));
    switch feature
        case 1
             % POS tagged sentence starting with Wh-word
             result = checkInterrogative(xbar);
        case 2
             % POS tagged sentence starting with adverbs
             result = checkAdverbs(xbar);
        case 3
             % Sentence starting with auxiliary verb
             result = checkAuxiliary(xbar);
        case 4
            % Return for a period
            result = checkPeriod(xbar,i);             
        otherwise
            % Do something??
            result = 0;
    end
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
