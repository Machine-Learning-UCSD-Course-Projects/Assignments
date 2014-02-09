function sgd(x, trueY)
    ff = featureFunction();
    w = zeroes(numel(ff));
    iterations = 1000;
    lambda = 0.1;
    if (size(x,2) + 2) ~= size(trueY, 2)
        error('size(x,2) != size(y, 2)');
    end
    for i = 1:iterations
        yhat = Inference(x, w);
        for j = 1:numel(ff)
            yhat = Inference(x, w);
            w(j) = w(j) + lambda * (computeF(ff{j}, x, trueY) - computeF(ff{j}, x, yhat));
        end
    end
end

function sum = computeF(ffj, x, trueY)
    sum = 0;
    % Starts from 2 because this contains all the Ys including START and STOP
    % while in notes y_0 and y_{n+1} is assumed outside n tags of Y and
    % words of X
    for i = 2:size(trueY,2)
        sum = sum + ffj(trueY(i - 1), trueY(i), x, i);
    end
end