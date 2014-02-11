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
    lambda = 0.8;
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    M = size(allY, 2);
    for i = 1:epochs
        for l = 1:size(sentences, 1)
            disp(l);
            x = sentences{l};
            N = size(x, 2);
            g = computeG(x, allY, w);
            alpha = computeAlpha(M, N, g);
            beta = computeBeta(M, N, g);
            Z = computeZ(alpha,M,N);
            for j = 1:numFF
                F = computeF(j, x, trueY{l});
                E = computeE(M, N, j, g, x, alpha, beta, Z);
                w(j) = w(j) + lambda * (F - E);
            end
        end
        disp('End of an epoch')
        disp(nnz(w))
    end
end
function sum = computeF(j, x, trueY)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    for i = 1:size(x,2)
        sum = sum + A(j, x, i) * B(j, trueY(i), trueY(i + 1));
    end
end