function x=computeZ_usingBeta(beta)
%M : Size of tag set
%N : Number of words in a sentence
%Assume that alpha matrix exists in memory
%Assume that N is a variable that equals length of the sentence
%(Including the 2 extra START and STOP tags
x=0;
for v=1:M
    % Tag 1 = START
    x = x + exp(getG(1,1,v))*beta(v,1)
end