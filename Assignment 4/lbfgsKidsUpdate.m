% function val = lbfgsKidsUpdate()
%     x = zeros(2, 1);    
%     val = minFunc(@norm, x);
% end
% 
% function [val, grad]= norm(x)
%     val = sin(x(1)) + cos(x(2));
%     if nargout>1
%         grad = zeros(2, 1);
%         grad(1) = cos(x(1));
%         grad(2) = -sin(x(2));
%     end
% end
function val = lbfgsKidsUpdate(sentences, t, W, V, vocab)
    d = size(W, 1);
    options.Method = 'lbfgs';
    VOCABCOUNT = size(vocab, 1);
    vars = zeros(VOCABCOUNT, d);
    for it = 1 : size(sentences, 2)
        for jt = 1 : size(sentences{1, it}, 1)
            p = sentences{1, it}(jt);
            vars(p,:) = vocab(p,:);
        end
    end
    vars = reshape(vars, VOCABCOUNT * d, 1);
    vars = minFunc(@E2ForLbfgs, vars, options, sentences, t, W, V, vocab);
    vars = reshpape(vars, VOCABCOUNT, d);
    for it = 1 :  VOCABCOUNT
        vocab(p, :) = vars(p, :);
    end
    val = vocab;
end

function [val, grad] = E2ForLbfgs(vars, sentences, t, W, V, vocab)
    d = size(W, 1);
    val = 0;
    VOCABCOUNT = size(vocab, 1);
    for it = 1 : size(sentences, 2)
        for jt = 1 : size(sentences{1, it}, 1) % Find if sentences{it} is a cell array?
            p = sentences{1, it}(jt);
            xp = vars((p - 1) * d + 1 : p * d ); % 1 : d, d + 1 : 2d
            val = val + E2(t, V, xp);
        end
    end
    grad = zeros(VOCABCOUNT, d);
    for it = 1 : size(sentences, 2)
        for jt = 1 : size(sentences{1, it}, 1) % Find if sentences{it} is a cell array?
            p = sentences{1, it}(jt);
            xp = vars((p - 1) * d + 1 : p * d ); % 1 : d, d + 1 : 2d
            for kt = 1 : d
                grad(p, kt) = grad(p, kt) + dE2Bydx(kt, xp, V, t);
            end
        end
    end
    grad = reshape(grad, VOCABCOUNT * d, 1);
end

function val = E2(t, V, xp)
    val = 0;
    for i = 1:size(t, 2)
        if t(i) == 1
            val = val + t(i) * log(sm(V, xp', i));
        else
            val = val + (1 - t(i)) * log(1 - sm(V, xp', i));
        end
    end
end