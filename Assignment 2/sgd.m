function w = sgd(sentences, trueY)
    CACHED_W=[];
    checkpoint_count = 0;
    for l = 1:size(sentences, 1)
        if (size(sentences{l}, 2) + 2) ~= size(trueY{l}, 2)
            disp(l)
            error('Dimensions of sentence and trueY do not match');
        end
    end
    numFF = numFeatureFunctions();
    w = zeros(numFF,1);
    epochs = 1;
    lambda = 0.0001;
    %mu = 0.00000001;
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    M = size(allY, 2);
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS NUM_LABEL_TAGS_SQUARE CACHED_B;
    for i = 1:epochs
        for l = 1:size(sentences, 1)
            
            if sum(isnan(w))>0
                error('Nan in w');
                disp(l);
            end
            
            if mod(l,3000) == 0
                checkpoint_count = checkpoint_count + 1;
                disp('BEGIN CHECKPOINT!');
                [tag,sentence]=calculate_accuracy(w);
                disp('END CHECKPOINT!');
                disp(tag);
                disp(sentence);
                CACHED_W(checkpoint_count,:)=w';
            end
            disp(l);
            x = sentences{l};
            %x(x==-1) = 37;
            N = size(x, 2);
            g = computeG(x, allY, w);
            alpha = computeAlpha(M, N, g);
            beta = computeBeta(M, N, g);
            Z = computeZ(alpha,M,N);
            cachedA = getA(NUM_FEATURE_TAGS, x);
%             for j = 1:numFF
%                 [ja, jb, prev_tag, current_tag] = featureFunctionVars(j);
%                 F1 = computeFNew(ja, prev_tag, current_tag, x, trueY{l});
%                 %F = computeF(j, x, trueY{l});
%                 
%                 E = computeE(M, N, j, prev_tag, current_tag, g, x, alpha, beta, Z);
%                 w(j) = w(j) + lambda * (F1 - E);
%             end
            j = 1;
            %regularizationTerm = mu * dot(w,w');
            for ja = 1:NUM_FEATURE_TAGS
                for l2 = 1:NUM_LABEL_TAGS
                    for l3 = 1:NUM_LABEL_TAGS
                        F = computeFNew(cachedA, ja, l2, l3, x, trueY{l});
                        E = computeE(M, N, cachedA, ja, l2, l3, g, x, alpha, beta, Z);
                        w(j) = w(j) + lambda * (F - E);% - regularizationTerm;
                        j = j + 1;
                    end
                end
            end  
        end
        disp('End of an epoch')
        disp(nnz(w))
    end
end
% function a = getA(pos, x)
%     a = zeros(pos, size(x,2));
%     for i = 1:size(x,2)
%         for j = 1:pos
%             a(j,i) = A(j, x, i);
%         end
%     end
%     a(pos + 1, pos + 1) = 0;
% end

function a = getA(pos, x)
    a = zeros(pos, size(x,2));
    for i = 1:size(x,2)
        for j = 1:pos
            a(j,i) = A(j, x, i);
        end
    end
end

function sum = computeFNew(cachedA, ja, prev_tag, current_tag, x, trueY)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    global CACHED_B;
    for i = 1:size(x,2)
        sum = sum + cachedA(ja, i) * CACHED_B(prev_tag, current_tag, trueY(i), trueY(i + 1));
    end
end
function sum = computeF(j, x, trueY)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    global CACHED_B;
    [ja, jb, prev_tag, current_tag] = featureFunctionVars(j);
    for i = 1:size(x,2)
        sum = sum + A(ja, x, i) * CACHED_B(prev_tag, current_tag, trueY(i), trueY(i + 1));
    end
end