function alpha=computeAlpha(M,N,g)
%M : Size of tag set
%N : Number of words in a sentence
%Dummy comment
alpha=ones(N,M);
alpha(1,:)=0; % The entire first row of alpha matrix has zeros
alpha(1,1)=1; % alpha(0,y)=I(y=START)

for k=1:N-1 %ROWS
    for v=1:M % COLUMNS   
        tempsum=0;
        for u=1:M %sum over all u
            tempsum = tempsum + alpha(k,u)*exp(g(u,v,k+1)); %Assume that g is loaded in memory
        end
        alpha(k+1,v)=tempsum;
    end
end