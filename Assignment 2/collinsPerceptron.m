function w = collinsPerceptron(x, trueY)
   numFF = numFeatureFunctions();
    w = zeros(numFF);
    iterations = 10;
    lambda = 0.1;
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    if (size(x,2) + 2) ~= size(trueY, 2)
        error('size(x,2) != size(y, 2)');
    end
    M = size(allY, 2);
    N = size(x, 2);
    for i = 1:iterations
        disp(i)
        for j = 1:numFF
            yhat = Inference(x, w);
            disp(j)
       
            w(j) = w(j) + lambda * (computeF(j, x, trueY) ...
                - computeF(j, x, yhat));
            disp(j)
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