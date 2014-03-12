function [ T ] = buildAllTrees( X,W,U,sentence_sizes,N,d,positive_sentences,negative_sentences )
%BUILDALLTREES Summary of this function goes here
%   Detailed explanation goes here
    T=cell(N,1);
    wordcode_seed = 270000;
    %N=4; %Testing
    for i=1:N
        run_count=0;
        disp(i);
        tuple_count = 2*sentence_sizes(i)-1;
        T{i,1}=Tree(tuple_count);
        tempSentence = getSentence(i,positive_sentences,negative_sentences);
        tempX = {X{i,1:sentence_sizes(i)}};        
        for outerk = 1:sentence_sizes(i)-1
            %disp(outerk)            
            xk=[];
            error=[];
            %Calculate the errors for all Xi,Xj in tempX
            for k=1:sentence_sizes(i)-1-run_count
                %disp(k);
                try
                    Xi = tempX{1,k};
                    Xj = tempX{1,k+1};
                catch exception
                    disp('Oh shit');
                    disp(i)
                    exit
                end
                Xk = tan(W*vertcat(Xi,Xj,[1]));
                xk=[xk Xk];
                Z = U*Xk;
                Zi = Z(1:d);
                Zj = Z(d+1:2*d);
                e = dot(Xi-Zi,Xi-Zi) + dot(Xj-Zj,Xj-Zj);
                error = [error e];
            end
            %Sort error array
            %disp(error)
            [minimum,index]=min(error);
            
            %Find the 2 smallest element's i and j values corresponding to minimum error
            left_pos = index;
            right_pos = index+1;
            
            %Find the wordcodes corresponding to the i and j values
            left_wordcode = tempSentence(left_pos);
            right_wordcode =  tempSentence(right_pos);
            
            %Generate a new wordcode for the parent node            
            [ parent_wordcode,wordcode_seed ] = generate_new_code(wordcode_seed);
            
            %Insert these 2 elements-parent edges into Tree
            T{i,1}.insert(left_wordcode,parent_wordcode);
            T{i,1}.insert(right_wordcode,parent_wordcode);                                                
            
            %Delete these 2 elements from tempX                        
            tempX(1,left_pos)={xk(:,index)}; %Insert Xk into tempX                        
            tempX(right_pos)=[];
            
            %Delete the paired up positions from tempSentence
            %In their place, insert the new internal node represented by
            %parent_wordcode
            tempSentence(left_pos)=parent_wordcode;
            tempSentence(right_pos)=[];
            
            %Reduces the number of pairs being processed by 1 in every
            %iteration
            run_count = run_count+1;
        end
    end
end

function n = find_wordcode(sentence_id, position,positive_sentences,negative_sentences)
    if sentence_id <= numel(positive_sentences)
        n = positive_sentences{1,sentence_id}(position);
    else
        id = sentence_id-numel(positive_sentences);
        n = negative_sentences{1,id}(position);
    end
end

function [s] = getSentence(sentence_id,positive_sentences,negative_sentences)
    if sentence_id <= numel(positive_sentences)
        s = positive_sentences{1,sentence_id};
    else
        id = sentence_id-numel(positive_sentences);
        s = negative_sentences{1,id};
    end
end

function [code,wordcode_seed] = generate_new_code(wordcode_seed)
    code = wordcode_seed;
    wordcode_seed = wordcode_seed+1;
end