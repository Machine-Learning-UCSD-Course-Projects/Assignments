global POS_TRAINING_SENTENCES POS_TRAINING_LABELS
for i = 1:1000
    %Read sentence i from training sentences
    tempSentence = POS_TRAINING_SENTENCES(i,:);
    tempSentence(tempSentence == 0) =[];
    %disp('TEMP SENTENCE')
    %disp(tempSentence)
    
    %Read label i from training labels
    tempLabel = POS_TRAINING_LABELS(i,:);
    tempLabel(tempLabel <= 0) =[];
    tempLabel = cat(2,1,tempLabel+1,8);
    %disp('TEMP LABEL')
    %disp(tempLabel)
    if numel(tempSentence)+2 ~= numel(tempLabel)
        disp(i)
    end
end