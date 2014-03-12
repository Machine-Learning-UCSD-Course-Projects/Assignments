clear

[ X,W,U,V,d,N,Truelabels,sentence_sizes,positive_sentences,negative_sentences,Vocab,alpha,lambda ] = initialize_all();    
N=100;
[ T,Roots,Vocab ] = buildAllTrees( X,W,U,sentence_sizes,N,d,positive_sentences,negative_sentences,Vocab );
disp('All trees built');

%Now running LBFGS
[W, U, V]  = lbfgsWithoutKidsUpdate(W, U, V, alpha, lambda, Roots, Truelabels, T, Vocab);

%Finding out true labels after current epoch
calculate_accuracy(V,Roots,Vocab,N,Truelabels);

