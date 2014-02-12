function [ result ] = A(j, xbar, i)
    %global NUM_LABEL_TAGS_SQUARE;
    %feature = j;%ceil(j / NUM_LABEL_TAGS_SQUARE);
    %current_feature = xbar(i); % Need some way of loading tag data for xbar(i)
    %result = (j == xbar(i));
    if j < 37
        result = (j == xbar(i));
        return;
    end;
    
    if j == 37
        result = checkInterrogative(xbar);
        return;
    end;
    
    if j == 38
        result = checkAdverbs(xbar);
        return;
    end;
    
    if j == 39
        result = checkAuxiliary(xbar);
        return;
    end;
    
    if j == 40
        result = checkPeriod(xbar,i);
        return;
    end;
    
    if j == 41
        result = checkInterr(xbar,i);
        return;
    end;
    
    if j == 42
        result = checkStart(xbar,i);
        return;
    end;
    
    if j == 43
        result = checkMid(xbar,i);
        return;
    end;
    
    if j == 44
        result = checkEnd(xbar,i);
        return;
    end;
    
    if j > 44
        result = 0;
        if i == j - 44
            result = 1;
        end
        if i == 1 || i == numel(xbar)
            result = 2;
        end
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

function result = checkInterr(xbar, i)
    result = 0;
    if numel(xbar) == i
        if ismember([32,33,34,35],xbar(1))
            result = 1;
        end
    end
end

function result = checkEnd(xbar, i)
    result = 0;
    if numel(xbar) == i
        result = 1;
    end
end

function result = checkStart(xbar, i)
    result = 0;
    if i == 1
        result = 1;
    end
end

function result = checkMid(xbar, i)
    result = 0;
    if i > 1 && numel(xbar) > i
        result = 1;
    end
end

function result = checkTwo(xbar, i)
    result = xbar(i) * xbar(i-1);
end