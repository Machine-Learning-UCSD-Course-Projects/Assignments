clear

[ X,W,U,d,N,sentence_sizes,positive_sentences,negative_sentences,Vocab ] = initialize_all();
[ T ] = buildAllTrees( X,W,U,sentence_sizes,N,d,positive_sentences,negative_sentences );
disp('All trees built');

%[ Xk,k_sizes ] = calculate_Xk( W,X,N,sentence_sizes );
%[ E ] = calculate_error(U,X,Xk,k_sizes,N,d);


