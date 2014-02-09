function g = computeG(x, allY, w)
    %The equation below equation 4 in the notes Pg 7
    g = zeros(size(allY, 2), size(allY, 2), size(x, 2));
    for i = 1:size(x, 2)
        for u = 1:size(allY, 2)
            for v = 1:size(allY, 2)
                g(u, v, i) = gi(allY(u), allY(v), x, i, numFeatureFunctions(), w);
            end
        end
    end