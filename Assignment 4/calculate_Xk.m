function [ Xk,k_sizes ] = calculate_Xk( W,X,N,sentence_sizes )
%Xk = h(W[xi;xj] + b)
%k_sizes has the max value of k for each sentences for fast lookup.
%NOTE : h() is assumed to be tan() function

    Xk = cell(N,1);
    k_sizes = zeros(N,1);
    
    %For every sentences
    for i=1:N
        %Calculate maximum value of k
        %There are n-1 pairs in each sentence
        max_k = sentence_sizes(i)-1;
        
        %Store max_k for future lookup
        k_sizes(i) = max_k;
        
        %Pick a pair of words
        for k = 1:max_k
            Xi = cell2mat(X(i,k));
            Xj = cell2mat(X(i,k+1));
            B=vertcat(Xi,Xj,[1]);
            Xk(i,k)={tan(W*B)};
        end
    end
end

