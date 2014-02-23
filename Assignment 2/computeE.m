function sum=computeE(M,N,cachedA,ja,prev_tag, current_tag,g,xbar,alpha,beta, Z)
%M : Size of tag set
%N : Number of words in a sentence
%ffj : F_subscript{j}
sum = 0;
global CACHED_B;
for i=1:N
    %a = A(ja, xbar, i);
    a = cachedA(ja, i);
    if a ~= 0
        for yiminus1=1:M
            prod = a * alpha(i,yiminus1);
            for yi=1:M
                sum = sum + prod * CACHED_B(prev_tag, current_tag, yiminus1,yi) ...
                * exp(g(yiminus1,yi,i)) ...
                * beta(yi,i) ...
                / Z;
            end
        end
    end
end
