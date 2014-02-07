function yhat = Inference(x, w)
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    g = computeG(x, allY, w);
    U = computeU(g, x, allY);
    U
    yhat = zeros(size(x, 2), 1);
    % Page no 8 in notes
    [z, yhat(size(x, 2))] = max(U(size(x, 2),:), [], 2);
    for k = size(x, 2) : -1 : 2
        % on u
        [z, yhat(k - 1)] = max(U(k - 1,:) + g(k,:,allY(yhat(k))), [], 2);
    end
end
 % Page no 8 in notes
 function U = computeU(g, x, allY)
    U = zeros(size(x, 2), size(allY, 2));
    for v = 1:size(allY,2)
        % on u
        U(1,v) = max(g(1, :, v), [], 2);
    end
    for k = 2:size(x, 2)
        for v = 1:size(allY, 2)
            % on u
            [U(k,v), z] = max(U(k - 1,:) + g(k,:,v), [], 2);
        end
    end
 end