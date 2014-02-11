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
    for i = 1:epochs
        for l = 1:size(sentences, 1)
            disp(l);
            x = sentences{l};
            yhat = Inference(x, w);
            for j = 1:numFF
                w(j) = w(j) + lambda * (computeF(j, x, trueY{l}) ...
                    - computeF(j, x, yhat));
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