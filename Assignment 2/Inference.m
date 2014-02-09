function yhat = Inference(x, w)
    if numFeatureFunctions() ~= size(w,1)
        error(' numfeatureFunctions() ~= size(w,1) Failed');
    end
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    g = computeG(x, allY, w);
    U = computeU(g, x, allY);
    yhat = zeros(size(x, 2) + 2, 1);
    % Page no 8 in notes
    [z, yhat(size(x, 2) + 1)] = max(U(size(x, 2),:), [], 2);
    yhat(1) = allY(1);
    yhat(size(yhat,1)) = allY(8);
    for k = size(x, 2) + 1 : -1 : 2
        % on u
        %yhat(1) = START and y(n+2) = STOP
        [z, yhat(k - 1)] = max(U(k - 1,:) + g(k,:,allY(yhat(k))), [], 2);
    end
end
 % Page no 8 in notes
 function U = computeU(g, x, allY)
    U = zeros(size(x, 2), size(allY, 2));
    for v = 1:size(allY,2)
        % on u
        [U(1,v) z] = max(g(:, v, 1)', [], 2);
    end
    for k = 2:size(x, 2)
        for v = 1:size(allY, 2)
            % on u
            [U(k,v), z] = max(U(k - 1,:) + g(:, v, k)', [], 2);
        end
    end
 end