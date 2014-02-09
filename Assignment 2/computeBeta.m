function beta=computeBeta(M,N,g)
%M : Size of tag set
%N : Number of words in a sentence
%Dummy comment
beta=ones(M,N);
beta(:,N)=0; % The entire last column of beta matrix has zeros
beta(M,N)=1; % beta(u,n+1)=I(y=STOP)


for k=N-1:-1:1 % COLUMNS
    for u=1:M %ROWS
        tempsum=0;
        for v=1:M %sum over all u
            tempsum = tempsum + exp(g(u,v,k+1))*beta(v,k+1);
        end
        beta(u,k)=tempsum;
    end
end