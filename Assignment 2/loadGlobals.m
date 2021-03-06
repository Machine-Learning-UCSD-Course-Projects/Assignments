function loadGlobals()
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS NUM_LABEL_TAGS_SQUARE ...
        FEATURE_TAGS LABEL_TAGS ...
        POS_TRAINING_SENTENCES POS_TRAINING_LABELS ...
        POS_VALIDATION_SENTENCES POS_VALIDATION_LABELS ...
        POS_TEST_SENTENCES POS_TEST_LABELS ...
        AUXILIARY_TRAINING CACHED_B
    
    NUM_ACTUAL_FEATURE_TAGS = 63;
    NUM_POS_TWO_TAGS = 36 * 36;
    NUM_FEATURE_TAGS = NUM_ACTUAL_FEATURE_TAGS; %Because there are 4 FF templates. Previously 36
    FEATURE_TAGS = NUM_ACTUAL_FEATURE_TAGS; %Because there are 4 FF templates. Previously 36
    LABEL_TAGS = { 'START', 'COMMA', 'PERIOD', 'QUESTION_MARK', 'EXCLAMATION_POINT', 'COLON', 'SPACE', 'STOP' };
    NUM_LABEL_TAGS = numel(LABEL_TAGS);
    NUM_LABEL_TAGS_SQUARE = NUM_LABEL_TAGS ^ 2;
    CACHED_B = getB(numel(LABEL_TAGS));
    if size(POS_TRAINING_SENTENCES, 1) == 0
        POS_TRAINING_SENTENCES = csvread('./CSV/trainingSentences.csv');
        POS_TRAINING_LABELS = csvread('./CSV/trainingLabels.csv');
        POS_VALIDATION_SENTENCES = csvread('./CSV/validationSentences.csv');
        POS_VALIDATION_LABELS = csvread('./CSV/validationLabels.csv');
        POS_TEST_SENTENCES = csvread('./CSV/testSentences.csv');
        POS_TEST_LABELS = csvread('./CSV/testLabels.csv');
        AUXILIARY_TRAINING = csvread('./CSV/auxiliary.csv');
    end
end

function B = getB(ySize)
    B = zeros(ySize, ySize, ySize, ySize);
    for i = 1:ySize
        for j = 1:ySize
            for k = 1:ySize
                for l = 1:ySize
                    B(i,j, k, l) = (i == k && j == l);
                end
            end
        end
    end
end
