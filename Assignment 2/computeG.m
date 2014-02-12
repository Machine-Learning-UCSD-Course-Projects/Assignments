% function g = computeG(x, allY, w)
%     %The equation below equation 4 in the notes Pg 7
%     g = zeros(size(allY, 2), size(allY, 2), size(x, 2));
%     numFF = numFeatureFunctions();
%     for i = 1:size(x, 2)
%         for j = 1 : numFF
%             [ja, jb, prev_tag, current_tag] = featureFunctionVars(j);
%             a = A(ja, x, i);
%             if a ~= 0
%                 for u = 1:size(allY, 2)
%                     for v = 1:size(allY, 2)
%                         g(u, v, i) = g(u, v, i) + w(j) * a * B(jb, prev_tag, current_tag, u, v);
%                     end
%                 end
%             end
%         end
%     end
% end

function g = computeG(x, allY, w)
    global NUM_LABEL_TAGS_SQUARE NUM_LABEL_TAGS NUM_FEATURE_TAGS CACHED_B;
    %The equation below equation 4 in the notes Pg 7
    g = zeros(size(allY, 2), size(allY, 2), size(x, 2));
    for i = 1:size(x, 2)
        j = 1;
        for ja = 1:NUM_FEATURE_TAGS
            a = A(ja, x, i);
            if(a ~= 0)
                for l2 = 1:NUM_LABEL_TAGS
                    for l3 = 1:NUM_LABEL_TAGS
                        for u = 1:size(allY, 2)
                            for v = 1:size(allY, 2)
                                g(u, v, i) = g(u, v, i) + w(j) * a * CACHED_B(l2, l3, u, v);
                            end
                        end
                        j = j + 1;
                    end
                end
            else
                j = j + NUM_LABEL_TAGS_SQUARE;
            end
        end
    end
end