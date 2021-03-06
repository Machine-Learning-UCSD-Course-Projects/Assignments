%Test the Inferred values against the real thing
%Assume that a weight vector w exists in memory

function [tag,sentence]=calculate_accuracy(w)
    global POS_TEST_LABELS POS_TEST_SENTENCES ...
        POS_VALIDATION_LABELS POS_VALIDATION_SENTENCES
    SAMPLESIZE = 500;
    TOTAL_LENGTH = 0;
    TAG_LEVEL_MATCH = 0;
    accuracy = 0;
    for i=1:SAMPLESIZE
        x=POS_VALIDATION_SENTENCES(i,:);
        y=POS_VALIDATION_LABELS(i,:);
        x(x==0)=[];
        y(y==0)=[];
        y=cat(2,1,y+1,8);
        yhat=Inference(x,w);

        %for k = 2:numel(yhat) - 2
        %	yhat(k) = 7;
        %end;
        %yhat(numel(yhat) - 1) = 3;
        %disp(yhat)
        if numel(yhat)==numel(y') 
        TAG_LEVEL_MATCH = TAG_LEVEL_MATCH + nnz(yhat == y');
        TOTAL_LENGTH = TOTAL_LENGTH + numel(y);
            if isequal(yhat,y')
            accuracy = accuracy + 1;
        else
            %disp(i);
            end
        end

    end
    %disp('SENTENCE LEVEL ACCURACY');
    %disp(accuracy/SAMPLESIZE)
    sentence = accuracy/SAMPLESIZE;
    %disp('TAG LEVEL ACCURACY');
    %disp(TAG_LEVEL_MATCH/TOTAL_LENGTH);
    tag = TAG_LEVEL_MATCH/TOTAL_LENGTH;
end