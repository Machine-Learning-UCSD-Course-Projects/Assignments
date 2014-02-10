function w = collinsPerceptron(sentences, trueY)
    numFF = numFeatureFunctions();
    w = zeros(numFF, 1);
    epochs = 1;
    lambda = 0.1;
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    if (size(sentences,2) + 2) ~= size(trueY, 2)
        error('size(x,2) != size(y, 2)');
    end
    M = size(allY, 2);
    N = size(sentences, 2);
    for i = 1:epochs
        yhat = cell(1, size(sentences, 1));
        for j = 1:numFF
            for l = 1:size(sentences, 1)
                x = sentences(l,:);
                if ifAReturnsNonZero(j, x) == 1 %1 = TRUE
                    if size(yhat{l}, 1) == 0
                        disp(l);
                        yhat{l} = Inference(x, w);
                    end
                    w(j) = w(j) + lambda * (computeF(j, x, trueY(l,:)) ...
                        - computeF(j, x, yhat{l}));
                end
            end
        end
    end
end

function sum = computeF(j, x, y)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    for i = 1:size(x,2)
        sum = sum + computeFeatureFunction(j, y(i), y(i+1), x, i);
    end
end