function [ja jb prev_tag current_tag] = featureFunctionVars(j)
    global NUM_LABEL_TAGS_SQUARE NUM_LABEL_TAGS;
    ja = ceil(j / NUM_LABEL_TAGS_SQUARE);
    jb = mod(j, NUM_LABEL_TAGS_SQUARE);
    if jb == 0
        jb = (NUM_LABEL_TAGS_SQUARE);
    end;
    prev_tag = ceil(jb / NUM_LABEL_TAGS);
    current_tag = mod(jb, NUM_LABEL_TAGS);
	if current_tag == 0
		current_tag = NUM_LABEL_TAGS;
	end;
end