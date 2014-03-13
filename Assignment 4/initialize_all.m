function [ X,W,U,V,d,N,Truelabels,sentence_sizes,positive_sentences,negative_sentences,Vocab,alpha,lambda ] = initialize_all()    
        
    %Alpha - hyperparameter for LBFGS
    alpha = 0.2;
    
    %Lambda - hyperparameter for LBFGS
    lambda = 0.0001;
    
    %As per Elkan, set d to 20
    d=20;

    %Load positive sentences
    load('codeDataMoviesEMNLP/data/rt-polaritydata/rt-polarity_pos_binarized.mat','allSNum');
    positive_sentences = allSNum;
    %Train
    positive_sentences=positive_sentences(1:3200);
    %Validation
    %positive_sentences=positive_sentences(3201:4800);
    %Test
    %positive_sentences=positive_sentences(4800:5331);
    
    %Load negative sentences
    load('codeDataMoviesEMNLP/data/rt-polaritydata/rt-polarity_neg_binarized.mat','allSNum');
    negative_sentences = allSNum;
    %Deleting sentence numbers 588,1219,4470
    negative_sentences{1,588}=[];
    negative_sentences{1,1219}=[];
    negative_sentences{1,4470}=[];
    
    %Train
    negative_sentences=negative_sentences(1:3200);
    %Validation
    %negative_sentences=negative_sentences(3201:4800);
    %Test
    %negative_sentences=negative_sentences(4800:5328);
    
    %In this dataset, there are 5331 negative 
    %and 5331 positive reviews
    N=numel(positive_sentences)+numel(negative_sentences);

    %Load true values
    Truelabels=zeros(N,2);
    for i=1:numel(positive_sentences)
        Truelabels(i,:)=[1 0];
    end
    for i=(numel(positive_sentences)+1):numel(positive_sentences)+numel(negative_sentences)
        Truelabels(i,:)=[0 1];
    end
    
        
    %In this dataset 
    %Initialize [W b]
    W = rand(d,2*d+1);
   
    %Initialize [U c]
    U = rand(2*d,d+1);
    
    %Needed for learning
    V = rand(2, d + 1);
    
    %----------------------------------------------------------------------
    %Build a list of word code ---> dx1 vector mapping
    Vocab = zeros(1,d);
    
    %Build dictionary for all positive sentences
    for i=1:numel(positive_sentences)
        sentence = positive_sentences{1,i};
        for j=1:numel(sentence)
            if sentence(j) <= size(Vocab,1)
                if sum(Vocab(sentence(j),:))==0
                    Vocab(sentence(j),:) = rand(d, 1)';
                end
            else
                Vocab(sentence(j),:) = rand(d, 1)';
            end                                      
        end
    end
    
    %Build dictionary for all negative sentences
    for i=1:numel(negative_sentences)
        sentence = negative_sentences{1,i};
        for j=1:numel(sentence)
            %i.e. If the array can accommodate the word code
            if sentence(j) <= size(Vocab,1) 
                %If the word code's corresponding vector has not yet been
                %added to the Vocab
                if sum(Vocab(sentence(j),:))==0
                    Vocab(sentence(j),:) = rand(d, 1)';
                end
            else
                Vocab(sentence(j),:) = rand(d, 1)';
            end                                      
        end
    end
    %----------------------------------------------------------------------
    
    
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
            wordcode = positive_sentences{1,i}(j);
            X(i,j) = {Vocab(wordcode,:)'};
        end
    end
    
    %Initialize the next 5331 X for negative sentences
    for i=1:numel(negative_sentences)
        size_of_ith_sentence = numel(cell2mat(negative_sentences(1,i)));
        sentence_sizes(i+numel(positive_sentences))=size_of_ith_sentence;
        for j=1:size_of_ith_sentence
            wordcode = negative_sentences{1,i}(j);
            %X(i,j) is a column vector of 1s and -1s
            X(i+numel(positive_sentences),j)={Vocab(wordcode,:)'};
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
