function x=computeAlpha(M,N)
%M : Size of tag set
%N : Number of words in a sentence
%Dummy comment
x=ones(N,M);
x(1,:)=0; % The entire first row of alpha matrix has zeros
x(1,1)=1; % alpha(0,y)=I(y=START)

for i=1:M % COLUMNS
    for j=2:N %ROWS
        tempsum=0;
        for k=1:M %sum over all u
            %Code | Class notes
            %   k | u
            %   i | v
            %   j | k+1
            % j-1 | k
            %   x | alpha
            tempsum = tempsum + x(j-1,k)*exp(getG(j,k,i)); %Assume that g is loaded in memory
        end
        x(j,i)=tempsum;
    end
end