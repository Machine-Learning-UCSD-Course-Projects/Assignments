function sum=computeE(M,N,j,g,xbar,alpha,beta, Z)
%M : Size of tag set
%N : Number of words in a sentence
%ffj : F_subscript{j}
sum = 0;
for i=1:N
    a = A(j, xbar, i);
    if a ~= 0
        for yiminus1=1:M
            prod = a * alpha(i,yiminus1);
            for yi=1:M
                sum = sum + prod * B(j,yiminus1,yi) ...
                * exp(g(yiminus1,yi,i)) ...
                * beta(yi,i) ...
                / Z;
            end
        end
    end
end
