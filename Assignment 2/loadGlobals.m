function loadGlobals()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS FEATURE_TAGS LABEL_TAGS
    
    NUM_FEATURE_TAGS = 36;
    FEATURE_TAGS = 36;
    LABEL_TAGS = { 'START', 'COMMA', 'PERIOD', 'QUESTION_MARK', 'EXCLAMATION_POINT', 'COLON', 'SPACE', 'STOP' };
    NUM_LABEL_TAGS = numel(LABEL_TAGS);
    
end

