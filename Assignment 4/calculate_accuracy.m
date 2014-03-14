function [ accuracy ] = calculate_accuracy( V,Roots,Vocab,N,Truelabels )
%CALCULATE_ACCURACY Summary of this function goes here
%   Detailed explanation goes here
predictions=zeros(N,2);
for i=1:N    
    p_label1 = sm(V,Vocab(Roots(i),:),1);
    p_label2 = sm(V,Vocab(Roots(i),:),2);
    if p_label1>=0.5
        p_label1=1;
    else
        p_label1=0;
    end
    
    if p_label2>=0.5
        p_label2=1;
    else
        p_label2=0;
    end
    predictions(i,:)=[p_label1 p_label2];
end
accuracy = sum(sum(predictions(:,:)==Truelabels(1:N,:)))/2;
%accuracy = 0;
disp('Accuracy');
disp(accuracy);
end

