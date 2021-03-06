function [loglikelihood, gradient] = bowLogisticReg(w,allSNum,y, d)
    loglikelihood = 0;
    gradient = zeros(size(w));
    V(1,:) = w(1:d)';
    V(2,:) = w((d+1):(2*d))';
    for i = 1:size(allSNum,1)
        for j = 1:size(allSNum{i}, 2)
            x_start = allSNum{i}(j);
            x_start = (x_start + 1) * d + 1;%?
            X = w(x_start:(x_start + d - 1));
% <<<<<<< HEAD
            loglikelihood = loglikelihood - sum(y(i) * log(1./(1+exp(-V(2,:)*X)))) - sum((1 - y(i)) * (1 - log(1./(1+exp(-V(1,:)*X)))));           
            %loglikelihood = loglikelihood - sum(y(i) * log(1./(1+exp(-V*X)))) - sum((1 - y(i)) * (1 - log(1./(1+exp(-V*X)))));           
            for k = 1:d
                % Kashyap: made modifications to some of the expressions
                % below to have V(1, :) or V(2, :) in the exp().
                % Funnily, overall is not making much difference either
                % way.
                gradient(x_start + k - 1, 1) = gradient(x_start + k - 1, 1) + (y(i) - (1 ./ 1 + exp(-V(1, :) * X))) * V(1, k) + (y(i) - (1 ./ 1 + exp(-V(2, :) * X))) * V(2, k);
                gradient(k, 1) = gradient(k, 1) + (y(i) - (1 ./ 1 + exp(-V(1, :) * X))) * X(k);
                gradient(d + k, 1) = gradient(d + k, 1) + (y(i) - (1 ./ 1 + exp(-V(2, :) * X))) * X(k);
                
%                 add = (y(i) - (1 ./ 1 + exp(-V(1, :) * X))) * V(1, k);
%                 gradient(x_start + k - 1, 1) = gradient(x_start + k - 1, 1) + add;
%                 add = ((1 - y(i)) - (1 ./ 1 + exp(-V(2, :) * X))) * V(1, k);
%                 gradient(x_start + k - 1, 1) = gradient(x_start + k - 1, 1) + add;
%                 add = ((1 - y(i)) - (1 ./ 1 + exp(-V(1, :) * X))) * X(k);
%                 gradient(x_start + k - 1, 1) = gradient(x_start + k - 1, 1) + add;
%                 add = (y(i) - (1 ./ 1 + exp(-V(2, :) * X))) * X(k);
%                 gradient((y(i) * d) + k, 1) = gradient((y(i) * d) + k, 1) + add;
            end;
% =======
%             
%             loglikelihood = loglikelihood -1*sum(y(i) * log(1./(1+exp(-V*X))));            
%             
%             add = (y(i) - (1 ./ 1 + exp(-V(y(i) + 1, :) * X))) .* V(y(i) + 1, :)';
%             gradient((x_start):(x_start + d - 1), 1) = gradient((x_start):(x_start + d - 1), 1) + add;
%             add = (1 - y(i) - (1 ./ 1 + exp(-V(2 - y(i), :) * X))) .* V(2 - y(i), :)';
%             gradient((x_start):(x_start + d - 1), 1) = gradient((x_start):(x_start + d - 1), 1) + add;
%             add = (y(i) - (1 ./ 1 + exp(-V(y(i) + 1, :) * X))) .* X;
%             gradient(1:d, 1) = gradient(1:d, 1) + add;
%             add = (1 - y(i) - (1 ./ 1 + exp(-V(2 - y(i), :) * X))) .* X;
%             gradient((d + 1):(2 * d), 1) = gradient((d + 1):(2 * d), 1) + add;
% >>>>>>> 671e26331ca13b83087e1b966bc1fcf8f29ec8c5
         end;
    end;