function sum=computeE(M,N,j,g,xbar,alpha,beta,Z)
%M : Size of tag set
%N : Number of words in a sentence
%ffj : F_subscript{j}

sum = 0;
for i=2:N-1
    for yiminus1=1:M
        for yi=1:M
            sum = sum + ...
            computeFeatureFunction(j,yiminus1,yi,xbar,i) ...
            * alpha(i-1,yiminus1) ...
            * exp(g(yiminus1,yi,i)) ...
            * beta(yi,i) ...
            / Z;
        end
    end
end
