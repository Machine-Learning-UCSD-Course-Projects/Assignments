function x=computeBeta(M,N)
%M : Size of tag set
%N : Number of words in a sentence
%Dummy comment
x=ones(M,N);
x(:,N)=0; % The entire last column of beta matrix has zeros
x(M,N)=1; % beta(u,n+1)=I(y=STOP)

for j=1:N %ROWS
    for i=M-1:-1:1 % COLUMNS
        tempsum=0;
        for k=1:M %sum over all u
            %Code | Class notes
            %   j | u
            %   k | v
            % i+1 | k+1
            %   i | k
            %   x | beta
            tempsum = tempsum + exp(g(i+1,j,k))*x(k,i+1);
        end
        x(j,i)=tempsum;
    end
end