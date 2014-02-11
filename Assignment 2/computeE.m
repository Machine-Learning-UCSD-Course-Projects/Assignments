function sum=computeE(M,N,j,g,xbar,alpha,beta, Z)
%M : Size of tag set
%N : Number of words in a sentence
%ffj : F_subscript{j}
sum = 0;
for i=1:N
    for yiminus1=1:M
        for yi=1:M
            a = A(j, xbar, i);
            if a ~= 0
                b = B(j,yiminus1,yi);
                if b ~= 0
                    sum = sum + a * b ...
                    * alpha(i,yiminus1) ...
                    * exp(g(yiminus1,yi,i)) ...
                    * beta(yi,i) ...
                    / Z;
                end
            end
        end
    end
end
