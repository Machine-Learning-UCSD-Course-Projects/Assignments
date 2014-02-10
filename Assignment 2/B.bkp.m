function [ result ] = B(j, yiminus1, yi)
global NUM_LABEL_TAGS
    
    feature = ceil(j / (NUM_LABEL_TAGS ^ 2));
    switch feature
        case 1
             % POS tagged sentence starting with Wh-word 
             % should end in question mark
             result = checkInterrogative(yiminus1,yi);
        case 2
             % POS tagged sentence starting with adverbs
             % Should have a comma as the first tag
             result = checkAdverbs(yiminus1,yi);
        case 3
             % Sentence starting with auxiliary verb
             % should have question mark at the end.
             result = checkAuxiliary(yiminus1,yi);
        case 4
            % Return for a period
            result = checkPeriod(yiminus1,yi);             
        otherwise
            % Do something??
            result = 0;
    end
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
    if yiminus1==7 && yi==3
        result = 1;
    else
        result = 0;
    end
end

