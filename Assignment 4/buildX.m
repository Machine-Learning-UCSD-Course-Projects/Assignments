function X = buildX(Vocab,positive_sentences,negative_sentences,sentence_sizes )
%BUILDX Summary of this function goes here

%   Detailed explanation goes here

    %Initialize the matrix with all the X
    X = cell(N,1);
    
    %Store the size of each sentences for faster lookup later on
    sentence_sizes=zeros(N,1);
    
    %Initialize the first 5331 X for positive sentences
    for i=1:numel(positive_sentences)
        size_of_ith_sentence = numel(cell2mat(positive_sentences(1,i)));
        for j=1:size_of_ith_sentence
            %X(i,j) is a column vector of 1s and -1s
            wordcode = positive_sentences{1,i}(j);
            X(i,j) = {Vocab(wordcode,:)'};
        end
    end
    
    %Initialize the next 5331 X for negative sentences
    for i=1:numel(negative_sentences)
        size_of_ith_sentence = numel(cell2mat(negative_sentences(1,i)));
        for j=1:size_of_ith_sentence
            wordcode = negative_sentences{1,i}(j);
            %X(i,j) is a column vector of 1s and -1s
            X(i+numel(positive_sentences),j)={Vocab(wordcode,:)'};
        end
    end
    
end

