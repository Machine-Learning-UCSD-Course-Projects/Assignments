function x=computeZ_usingAlpha(alpha)
%M : Size of tag set
%N : Number of words in a sentence
%Assume that alpha matrix exists in memory
%Assume that N is a variable that equals length of the sentence
%(Including the 2 extra START and STOP tags
x=sum(alpha(N,:));