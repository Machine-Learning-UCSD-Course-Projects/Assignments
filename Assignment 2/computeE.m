function E=computeE(M,N,ffj,xbar)
%M : Size of tag set
%N : Number of words in a sentence
%ffj : F_subscript{j}
alpha=computeAlpha(M,N);
beta=computeBeta(M,N);
Z=computeZ_usingAlpha(alpha);

sum = 0;
for i=1:N
    for yiminus1=1:M
        for yi=1:M
            sum = sum + ...
            ffj(yiminus1,yi,xbar,i) ...
            * alpha(i-1,yiminus1) ...
            * exp(getG(i,yiminus1,yi)) ...
            * beta(yi,i) / Z;
        end
    end
end
