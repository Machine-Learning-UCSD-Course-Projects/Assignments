function w = sgd(sentences, trueY)
    for l = 1:size(sentences, 1)
        if (size(sentences{l}, 2) + 2) ~= size(trueY{l}, 2)
            disp(l)
            error('Dimensions of sentence and trueY do not match');
        end
    end
    numFF = numFeatureFunctions();
    w = zeros(numFF,1);
    epochs = 1;
    lambda = 0.1;
<<<<<<< HEAD
    mu = 0.00001;
=======
>>>>>>> 5c353cad2daf0b13febcb940041c36dd4a30d53d
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    M = size(allY, 2);
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS NUM_LABEL_TAGS_SQUARE CACHED_B;
    cachedA = getA(NUM_FEATURE_TAGS);
    for i = 1:epochs
        for l = 1:size(sentences, 1)
            disp(l);
            x = sentences{l};
            x(x==-1) = 37;
            N = size(x, 2);
            g = computeG(x, allY, w);
            alpha = computeAlpha(M, N, g);
            beta = computeBeta(M, N, g);
            Z = computeZ(alpha,M,N);
%             for j = 1:numFF
%                 [ja, jb, prev_tag, current_tag] = featureFunctionVars(j);
%                 F1 = computeFNew(ja, prev_tag, current_tag, x, trueY{l});
%                 %F = computeF(j, x, trueY{l});
%                 
%                 E = computeE(M, N, j, prev_tag, current_tag, g, x, alpha, beta, Z);
%                 w(j) = w(j) + lambda * (F1 - E);
%             end
            j = 1;
            regularizationTerm = mu * dot(w,w');
            for ja = 1:NUM_FEATURE_TAGS
                for l2 = 1:NUM_LABEL_TAGS
                    for l3 = 1:NUM_LABEL_TAGS
                        F = computeFNew(cachedA, ja, l2, l3, x, trueY{l});
                        E = computeE(M, N, cachedA, ja, l2, l3, g, x, alpha, beta, Z);
                        w(j) = w(j) + lambda * (F - E) - regularizationTerm;
                        j = j + 1;
                    end
                end
            end  
        end
        disp('End of an epoch')
        disp(nnz(w))
    end
end
function a = getA(pos)
    a = zeros(pos + 1, pos + 1);
    for i = 1:pos
        for j = 1:pos
            a(i,j) = (i == j);
        end
    end
    a(pos + 1, pos + 1) = 0;
end
function sum = computeFNew(cachedA, ja, prev_tag, current_tag, x, trueY)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    global CACHED_B;
    for i = 1:size(x,2)
        sum = sum + cachedA(ja, x(i)) * CACHED_B(prev_tag, current_tag, trueY(i), trueY(i + 1));
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