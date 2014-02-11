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
    lambda = 0.8;
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    M = size(allY, 2);
    N = size(sentences, 2);
    for i = 1:epochs
        yhat = cell(1, size(sentences, 1));
        for l = 1:size(sentences, 1)
<<<<<<< HEAD
            disp(l);
            for j = 1:numFF
                x = sentences{l};
                if size(yhat{l}, 1) == 0
                    disp(l);
                    yhat{l} = Inference(x, w);
=======
            for j = 1:numFF
                x = sentences{l};
                if ifAReturnsNonZero(j, x) == 1 %1 = TRUE
                    if size(yhat{l}, 1) == 0
                        disp(l);
                        yhat{l} = Inference(x, w);
                    end
                    w(j) = w(j) + lambda * (computeF(j, x, trueY(l,:)) ...
                        - computeF(j, x, yhat{l}));
>>>>>>> ce06cf55077d51370174961b23910aa011826d04
                end
                w(j) = w(j) + lambda * (computeF(j, x, trueY(l,:)) ...
                    - computeF(j, x, yhat{l}));
            end
        end
        disp('End of an epoch')
        disp(nnz(w))
    end
end

function sum = computeF(j, x, y)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    for i = 1:size(x,2)
        a = A(j, x, i);
        if a ~= 0
            sum = sum + a * B(j, y(i), y(i + 1));
        end
    end
end