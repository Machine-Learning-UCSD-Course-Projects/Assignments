function w = collinsPerceptron(sentences, trueY)
    for l = 1:size(sentences, 1)
        if (size(sentences{l}, 2) + 2) ~= size(trueY{l}, 2)
            disp(l)
            error('Dimensions of sentence and trueY do not match');
        end
    end
    numFF = numFeatureFunctions();
    w = zeros(numFF, 1);
    epochs = 1;
    lambda = 0.0005;
    for i = 1:epochs
        for l = 1:size(sentences, 1)
            disp(l);
            x = sentences{l};
            cachedA = getA(x);
            yhat = Inference(x, w);
%             for j = 1:numFF
%                 w(j) = w(j) + lambda * (computeF(j, x, trueY{l}) ...
%                     - computeF(j, x, yhat));
%             end
            w = computeFNew(cachedA, x, trueY{l}, yhat, w, lambda);
        end
        disp('End of an epoch')
        disp(nnz(w))
    end
end
function cachedA = getA(x)
    global NUM_FEATURE_TAGS;
    cachedA = zeros(NUM_FEATURE_TAGS, size(x,2));
    for i = 1:size(x,2)
        for ja = 1:NUM_FEATURE_TAGS
            cachedA(ja, i) = A(ja, x, i);
        end
    end
end
function w = computeFNew(cachedA, x, y, yhat, w, lambda)
    global NUM_FEATURE_TAGS NUM_LABEL_TAGS NUM_LABEL_TAGS_SQUARE CACHED_B;
    for i = 1:size(x,2)
        j = 1;
        for ja = 1:NUM_FEATURE_TAGS
            a = cachedA(ja, i);
            %a = A(ja, x, i);
            if(a ~= 0)
                for l2 = 1:NUM_LABEL_TAGS
                    for l3 = 1:NUM_LABEL_TAGS
                        w(j) = w(j) + lambda * a * (CACHED_B(l2, l3, y(i), y(i + 1)) - CACHED_B(l2, l3, yhat(i), yhat(i + 1)));
                        %(B(0, l2, l3, y(i), y(i + 1)) - B(0, l2, l3, yhat(i), yhat(i + 1)));
                        j = j + 1;
                    end
                end
            else
                j = j + NUM_LABEL_TAGS_SQUARE;
            end
        end
    end
end


function sum = computeF(j, x, y)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    [ja, jb, prev_tag, current_tag] = featureFunctionVars(j);
    for i = 1:size(x,2)
        sum = sum + A(ja, x, i) * B(jb, prev_tag, current_tag, y(i), y(i + 1));
    end
end