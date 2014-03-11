function [ T,new_codes ] = build_trees( N,Xk,k_sizes,E,sentence_sizes,positive_sentences,negative_sentences )
    %A tree of all trees
    T = cell(N,1);
    
    %A list of words codes being used for all the new internal nodes
    new_codes = [];
    
    %For every sentence
    for sentence = 1:N
        %Sort E{k}
        [sorted, indices] = sort(cell2mat(E(sentence)));
        
        %Get the original sentence
        if sentence <= numel(positive_sentences)
            original_sentence = cell2mat(positive_sentences(sentence));
        else
            original_sentence = cell2mat(negative_sentences(mod(sentence,numel(positive_sentences))));
        end
        
        tree = zeros(numel(indices),3);
        for k=1:k_sizes(sentence)
            % Take the pair with least error, say(i,j)
            % Find what word(code) is at ith position in sentences
            % Find what word(code) is at jth position in sentences
            % Since this code is a new internal node, insert it into 
            % new list. That last can later be concatenated with the 
            % global list of word codes
            tree(k,1)=original_sentence(indices(k)); 
            tree(k,2)=original_sentence(indices(k)+1);
            
            tree(k,3)=generate_code(sentence,sentence_sizes,indices(k));
            new_codes = [new_codes tree(k,3)]; %#ok<AGROW>
        end
        
        for iter = 1:2*sentence_sizes(sentence)
            
        end
    end
end

function x = generate_code(sentence,k_sizes,position)
    if sentence==1
        x = position;
    else
        x = k_sizes(sentence-1)+position;
    end
end

%Algorithm to build tree
            %Sort the error values            
            %Find indices i,j corresponding to k with least error
            %Delete these indices i,j from array            
            %Insert a new node corresponding to k in the array            
            %Repeat
            