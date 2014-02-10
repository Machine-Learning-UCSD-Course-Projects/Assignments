loadGlobals

global NUM_FEATURE_TAGS NUM_LABEL_TAGS FEATURE_TAGS LABEL_TAGS ...
        POS_TRAINING_SENTENCES POS_TRAINING_LABELS ...
        POS_VALIDATION_SENTENCES POS_VALIDATION_LABELS ...
        POS_TEST_SENTENCES POS_TEST_LABELS ...
        AUXILIARY_TRAINING
    
for i = 1:10
    %Initiate a list of sentences
    sentences = cell(10,1);
    
    %Initiate a list of true labels
    trueY = cell(10,1);
    
    %Read sentence i from training sentences
    tempSentence = POS_TRAINING_SENTENCE(i);
    tempSentence(tempSentence <= 0) =[];
    
    %Read label i from training labels
    tempLabel = POS_TRAINING_LABELS(i);
    
    %Append sentence i at end of list of sentences
    sentences{i} = tempSentence;
    
    %Append label i at end of list of labels
    trueY{i} = tempLabel;
    
    %Call SGD
    disp(sentences)
    disp(trueY)
end