function [loglikelihood, gradient] = bowLogisticReg(w,allSNum,y, d)
    loglikelihood = 0;
    gradient = zeros(size(w));
    V(1,:) = w(1:d)';
    V(2,:) = w((d+1):(2*d))';
    for i = 1:size(allSNum,1)
        for j = 1:size(allSNum{i}, 2)
            x_start = allSNum{i}(j);
            x_start = (x_start + 1) * d + 1;
            X = w(x_start:(x_start + d - 1));
            
            loglikelihood = loglikelihood -1*sum(y(i) * log(1./(1+exp(-V*X))));            
            
            add = (y(i) - (1 ./ 1 + exp(-V(y(i) + 1, :) * X))) .* V(y(i) + 1, :)';
            gradient((x_start):(x_start + d - 1), 1) = gradient((x_start):(x_start + d - 1), 1) + add;
            add = (1 - y(i) - (1 ./ 1 + exp(-V(2 - y(i), :) * X))) .* V(2 - y(i), :)';
            gradient((x_start):(x_start + d - 1), 1) = gradient((x_start):(x_start + d - 1), 1) + add;
            add = (y(i) - (1 ./ 1 + exp(-V(y(i) + 1, :) * X))) .* X;
            gradient(1:d, 1) = gradient(1:d, 1) + add;
            add = (1 - y(i) - (1 ./ 1 + exp(-V(2 - y(i), :) * X))) .* X;
            gradient((d + 1):(2 * d), 1) = gradient((d + 1):(2 * d), 1) + add;
        end;
    end;