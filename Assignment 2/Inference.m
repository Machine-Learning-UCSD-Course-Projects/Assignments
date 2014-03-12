function yhat = Inference(x, w)
    if numFeatureFunctions() ~= size(w,1)
        size(w)
        error(' numfeatureFunctions() ~= size(w,1) Failed');
    end
    allY = [1, 2, 3, 4, 5, 6, 7, 8];
    g = computeG(x, allY, w);
    U = computeU(g, x, allY);
    yhat = zeros(size(x, 2) + 2, 1);
    % Page no 8 in notes
    yhat(1) = allY(1);
    [z, yhat(size(x, 2) + 1)] = max(U(size(x, 2),:));
    yhat(size(x, 2) + 2) = allY(8);
    for k = size(x, 2) + 1 : -1 : 3
        %yhat(1) = START and y(n+2) = STOP
        m = 0;
        uMax = -Inf;
        lastG = 0;
        for u = 1:size(allY, 2)
            disp(yhat)
            currentU = U(k - 1,u) + g(u,yhat(k), k - 1);
            if uMax < currentU || uMax == currentU && lastG < g(u,yhat(k), k - 1)
                uMax = currentU;
                m = u;
                lastG = g(u,yhat(k), k - 1);
            end
        end
        yhat(k - 1) = m;
    end
end
 % Page no 8 in notes
 function U = computeU(g, x, allY)
    U = zeros(size(x, 2), size(allY, 2));
    U(:,:) = -Inf;
    for v = 1:size(allY,2)
        for u = 1:size(allY, 2)
            U(1,v) = max(g(u, v, 1), U(1,v));
        end
    end
    for k = 2:size(x, 2)
        for v = 1:size(allY, 2)
            for u = 1:size(allY, 2)
                U(k,v) = max(U(k - 1,u) + g(u, v, k), U(k,v));
            end
        end
    end
 end