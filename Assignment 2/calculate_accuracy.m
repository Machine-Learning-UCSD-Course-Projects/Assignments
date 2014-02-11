%Test the Infered values against the real thing
%Assume that a weight vector w exists in memory
accuracy = 0;
for i=1:SAMPLESIZE
    x=POS_TRAINING_SENTENCES(i,:);
    y=POS_TRAINING_LABELS(i,:);
    x(x==0)=[];
    y(y==0)=[];
    y=cat(2,1,y+1,8);
    yhat=Inference(x,w);
    if yhat == y'
        accuracy = accuracy + 1;
    else
        disp(i);
    end
end
disp(accuracy)