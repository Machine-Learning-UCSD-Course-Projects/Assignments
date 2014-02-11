function [ result ] = B(j, yiminus1, yi)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS
    
<<<<<<< HEAD
    feature = ceil(j / (NUM_LABEL_TAGS ^ 2));
   
         section = mod(j, (NUM_LABEL_TAGS ^ 2));
        if section == 0
            section = (NUM_LABEL_TAGS ^ 2);
        end;

        prev_tag = ceil(section / NUM_LABEL_TAGS);
        current_tag = mod(section, NUM_LABEL_TAGS);
        if current_tag == 0
            current_tag = 8;
        end;
        if yiminus1 == 7 && prev_tag == 7 && yi == 7 && 7 == current_tag
            yiminus1;
        end
        if yiminus1 == prev_tag && yi == current_tag
            result = 1;
        else
            result = 0;
        end;
end
=======
    section = mod(j, (NUM_LABEL_TAGS ^ 2));
	if section == 0
		section = (NUM_LABEL_TAGS ^ 2);
	end;
>>>>>>> 3482e377fd16902986fb6efe8058dcc4780e5669

    prev_tag = ceil(section / NUM_LABEL_TAGS);
    current_tag = mod(section, NUM_LABEL_TAGS);
	if current_tag == 0
		current_tag = 8;
	end;

    if yiminus1 == prev_tag && yi == current_tag
        result = 1;
    else
        result = 0;
<<<<<<< HEAD
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
=======
    end;
    
>>>>>>> 3482e377fd16902986fb6efe8058dcc4780e5669
end
