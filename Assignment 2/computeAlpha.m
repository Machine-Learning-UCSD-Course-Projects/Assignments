function x=computeAlpha(M,N)
%M : Size of tag set
%N : Number of words in a sentence
%Dummy comment
x=ones(M,N);
x(1,:)=0; % The entire first row of alpha matrix has zeros
x(1,1)=1; % alpha(0,y)=I(y=START)

for i=1:M % COLUMNS
    for j=2:N %ROWS
        tempsum=0;
        for k=1:M %sum over all u
            tempsum = tempsum + x(j-1,k)*exp(getG(i,x(j,k),x(j,i))); %Assume that g is loaded in memory
        end
        x(j,i)=tempsum;
    end
end