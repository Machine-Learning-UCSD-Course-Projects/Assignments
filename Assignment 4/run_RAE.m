clear

[ X,W,U,d,N,sentence_sizes,positive_sentences,negative_sentences ] = initialize_all();
[ Xk,k_sizes ] = calculate_Xk( W,X,N,sentence_sizes );
[ E ] = calculate_error(U,X,Xk,k_sizes,N,d);


