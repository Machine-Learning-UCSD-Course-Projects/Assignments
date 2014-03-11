function [ X,W,U,d,N,sentence_sizes,positive_sentences,negative_sentences ] = initialize_all()
    
    %Load positive sentences
    load('codeDataMoviesEMNLP/data/rt-polaritydata/rt-polarity_pos_binarized.mat','allSNum');
    positive_sentences = allSNum;
    
    %Load negative sentences
    load('codeDataMoviesEMNLP/data/rt-polaritydata/rt-polarity_neg_binarized.mat','allSNum');
    negative_sentences = allSNum;
    
    %As per Elkan, set d to 20
    d=20;
    
    %In this dataset, there are 5331 negative 
    %and 5331 positive reviews
    N=numel(positive_sentences)+numel(negative_sentences);
    
    %In this dataset 
    %Initialize [W b]
    W = rand(d,2*d+1);
   
    %Initialize [U c]
    U = rand(2*d+1,d);
    
    %----------------------------------------------------------------------
    %Initialize the matrix with all the X
    X = cell(N,1);
    
    %Store the size of each sentences for faster lookup later on
    sentence_sizes=zeros(N,1);
    
    %Initialize the first 5331 X for positive sentences
    for i=1:numel(positive_sentences)
        size_of_ith_sentence = numel(cell2mat(positive_sentences(1,i)));
        sentence_sizes(i)=size_of_ith_sentence;
        for j=1:size_of_ith_sentence
            %X(i,j) is a column vector of 1s and -1s
            X(i,j)={random_array(d)};
        end
    end
    
    %Initialize the next 5331 X for negative sentences
    for i=1:numel(negative_sentences)
        size_of_ith_sentence = numel(cell2mat(negative_sentences(1,i)));
        sentence_sizes(i+numel(positive_sentences))=size_of_ith_sentence;
        for j=1:size_of_ith_sentence
            %X(i,j) is a column vector of 1s and -1s
            X(i+numel(positive_sentences),j)={random_array(d)};
        end
    end
    %----------------------------------------------------------------------
end

%----------------------------------------------------------------------
%Helper functions
%----------------------------------------------------------------------
function x = random_array(d)
%Return a random vector of 1 and -1
    x=randi(2,d,1);
    x(x>1)=-1;
end
