%Test the Inferred values against the real thing
%Assume that a weight vector w exists in memory
<<<<<<< HEAD
SAMPLESIZE = 21035;
=======
<<<<<<< HEAD
SAMPLESIZE = 500;
=======
SAMPLESIZE = 1000;
>>>>>>> 055f6836800dc4f10ff829e5d647692df3840aa4
>>>>>>> 5c353cad2daf0b13febcb940041c36dd4a30d53d
TOTAL_LENGTH = 0;
TAG_LEVEL_MATCH = 0;
accuracy = 0;
for i=1:SAMPLESIZE
    x=POS_TRAINING_SENTENCES(i,:);
    y=POS_TRAINING_LABELS(i,:);
    x(x==0)=[];
    y(y==0)=[];
    y=cat(2,1,y+1,8);
    yhat=Inference(x,w);
    
<<<<<<< HEAD
=======
	
	%for k = 2:numel(yhat) - 2
	%	yhat(k) = 7;
	%end;
    %yhat(numel(yhat) - 1) = 3;
    %disp(yhat)
    
>>>>>>> 055f6836800dc4f10ff829e5d647692df3840aa4
    if numel(yhat)==numel(y') 
    TAG_LEVEL_MATCH = TAG_LEVEL_MATCH + nnz(yhat == y');
    TOTAL_LENGTH = TOTAL_LENGTH + numel(y);
        if isequal(yhat,y')
        accuracy = accuracy + 1;
    else
        disp(i);
        end
    end
    
end
disp('SENTENCE LEVEL ACCURACY');
disp(accuracy/SAMPLESIZE)
disp('TAG LEVEL ACCURACY');
disp(TAG_LEVEL_MATCH/TOTAL_LENGTH);
