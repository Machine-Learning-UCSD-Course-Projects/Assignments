clear

[ X,W,U,V,d,N,Truelabels,sentence_sizes,positive_sentences,negative_sentences,Vocab,alpha,lambda ] = initialize_all();    
N=100;
[ T,Roots,Vocab ] = buildAllTrees( X,W,U,sentence_sizes,N,d,positive_sentences,negative_sentences,Vocab );
disp('All trees built');

%Now running LBFGS
[W1, U1, V1] = lbfgsWithoutKidsUpdate(W, U, V, alpha, lambda, Roots, Truelabels, T, Vocab);

%Finding out true labels after current epoch
predictions=zeros(N,2);
for i=1:N    
    p_label1 = sm(V1,Roots(i),1);
    p_label2 = sm(V1,Roots(i),2);
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
accuracy = sum(sum(predictions==Truelabels))/2;
disp('Accuracy');
disp(accuracy);



