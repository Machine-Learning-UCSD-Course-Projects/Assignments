function beta=computeBeta(M,N)
%M : Size of tag set
%N : Number of words in a sentence
%Dummy comment
beta=ones(M,N);
beta(:,N)=0; % The entire last column of beta matrix has zeros
beta(M,N)=1; % beta(u,n+1)=I(y=STOP)

for u=1:N %ROWS
    for k=M-1:-1:1 % COLUMNS
        tempsum=0;
        for v=1:M %sum over all u
            tempsum = tempsum + exp(getG(k+1,u,v))*beta(v,k+1);
        end
        beta(u,k)=tempsum;
    end
end