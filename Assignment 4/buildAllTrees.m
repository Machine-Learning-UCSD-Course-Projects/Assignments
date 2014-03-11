function [ T ] = buildAllTrees( X,sentence_sizes,N,d,positive_sentences,negative_sentences )
%BUILDALLTREES Summary of this function goes here
%   Detailed explanation goes here
    T=cell(N,1);
    
    run_count=0;
    for i=1:N
        
        tuple_count = 2*sentence_sizes(i)-1;
        T{i,1}=tree(tuple_count);
        errors=[];
        for outerk = 1:sentence_sizes(i)-1
            tempX = {X{i,1:sentence_sizes(i)}};
            xk=[];
            %Calculate the errors for all Xi,Xj in tempX
            for k=1:sentence_sizes(i)-1-run_count
                Xi = tempX{i,k};
                Xj = tempX{i,k+1};
                Xk = tan(W*vertcat(Xi,Xj,[1]));
                xk=[xk Xk];
                Z = U*Xk;
                Zi = Z(1:d);
                Zj = Z(d+1:2*d);
                e = dot(Xi-Zi,Xi-Zi) + dot(Xj-Zj,Xj-Zj);
                error = [error e];
            end
                        
            %Sort error array
            [min,index]=min(error);
            
            %Find the 2 smallest element's i and j values corresponding to minimum error
            left_pos = index;
            right_pos = index+1;
            
            %Find the wordcodes corresponding to the i and j values
            left_wordcode = find_wordcode(i,left_pos,positive_sentences,negative_sentences);
            right_wordcode = find_wordcode(i,right_pos,positive_sentences,negative_sentences);
            
            %Generate a new wordcode for the parent node
            parent_wordcode = generate_new_code();
            
            %Insert these 2 elements-parent edges into Tree
            T{i,1}.insert(left_wordcode,parent_wordcode);
            T{i,1}.insert(left_wordcode,parent_wordcode);                                                
            
            %Delete these 2 elements from tempX
            tempX(left_pos)=xk(index); %Insert Xk into tempX
            tempX(right_pos)=[];
            
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

function code = generate_new_code()
    code = 999;
end