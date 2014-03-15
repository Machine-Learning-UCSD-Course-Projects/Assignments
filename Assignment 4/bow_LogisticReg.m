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
            loglikelihood = loglikelihood -1*sum(log(1./(1+exp(-V*X))));
            for k = 1:d
                add = (0 - (1 ./ 1 + exp(-V(1, :) * X))) * V(1, k);
                gradient(x_start + k - 1, 1) = gradient(x_start + k - 1, 1) + add;
                add = (1 - (1 ./ 1 + exp(-V(2, :) * X))) * V(2, k);
                gradient(x_start + k - 1, 1) = gradient(x_start + k - 1, 1) + add;
                add = (0 - (1 ./ 1 + exp(-V(1, :) * X))) * X(k);
                gradient(k, 1) = gradient(k, 1) + add;
                add = (0 - (1 ./ 1 + exp(-V(2, :) * X))) * X(k);
                gradient(d + k, 1) = gradient(d + k, 1);    
            end;
        end;
    end;