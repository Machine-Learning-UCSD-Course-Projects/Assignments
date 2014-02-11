function g = computeG(x, allY, w)
    %The equation below equation 4 in the notes Pg 7
    g = zeros(size(allY, 2), size(allY, 2), size(x, 2));
    numFF = numFeatureFunctions();
    
    for i = 1:size(x, 2)
        for j = 1 : numFF
            a = A(j, x, i);
            if a ~= 0
                for u = 1:size(allY, 2)
                    for v = 1:size(allY, 2)
                        g(u, v, i) = g(u, v, i) + w(j) * a * B(j, u, v);
                    end
                end
            end
        end
    end
end