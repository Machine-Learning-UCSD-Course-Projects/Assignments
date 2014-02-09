function w = sgd(sentences, trueY)
    if (size(sentences, 2) + 2) ~= size(trueY, 2)
        error('size(x,2) + 2 != size(y, 2)');
    end
    numFF = numFeatureFunctions();
    w = zeros(numFF);
    epochs = 1;
    lambda = 0.1;
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    for i = 1:epochs
        for l = 1:size(sentences, 2)
            x = sentences(l);
            M = size(allY, 2);
            N = size(x, 2);
            g = computeG(x, allY, w);
            alpha = computeAlpha(M, N, g);
            beta = computeBeta(M, N, g);
            for j = 1:numFF
                w(j) = w(j) + lambda * (computeF(j, x, trueY)...
                    - computeE(M, N, j, g, x, alpha, beta));
            end
        end
    end
end

function sum = computeF(j, x, trueY)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    for i = 1:size(x,2)
        sum = sum + computeFeatureFunction(j, trueY(i), trueY(i + 1), x, i);
    end
end