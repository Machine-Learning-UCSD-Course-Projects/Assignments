% function val = lbfgsWithoutKidsUpdate()
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

function [W1, U1, V1] = lbfgsWithoutKidsUpdate(W, U, V, alpha, lambda, pArray, t, treeArray, vocab)
    options.Method = 'lbfgs';
    options.progTol = 1e-10;
    options.maxIter = 10;
    
    d = size(vocab(1, :), 2);
    k = size(t, 2);
    vars = zeros(d * (2 * d + 1) + (2 * d) * (d + 1) + k * (d + 1), 1);
    ct = 1;
    %W
    for it = 1 : d
        for jt = 1 : 2 * d + 1
            vars(ct) = W(it, jt);
            ct = ct + 1;
        end
    end
    %U
    for it = 1 : 2 * d
        for jt = 1 : d + 1
            vars(ct) = U(it, jt);
            ct = ct + 1;
        end
    end
    %V
    for it = 1 : k
        for jt = 1 : d + 1
            vars(ct) = U(it, jt);
            ct = ct + 1;
        end
    end
    
    val = minFunc(@JForLbfgs, vars, options, alpha, lambda, pArray, t, treeArray, vocab);
    
    %Reshpaing begins
    s = 1;
    e = d * (2 * d + 1);
    W1 = reshape(val(s: e), d, 2 * d + 1);
    
    s = e + 1;
    e = e + (2 * d) * (d + 1);
    U1 = reshape(val(s : e), 2 * d, d + 1);
    
    s = e + 1;
    e = e + k * (d + 1);
    V1 = reshape(val(s : e), k, d + 1);
end
function [val, grad] = JForLbfgs(vars, alpha, lambda, pArray, t, treeArray, vocab)
    d = size(vocab(1, :), 2);
    k = size(t, 2);
    s = 1;
    e = d * (2 * d + 1);
    W = reshape(vars(s: e), d, 2 * d + 1);
    
    s = e + 1;
    e = e + (2 * d) * (d + 1);
    U = reshape(vars(s : e), 2 * d, d + 1);
    
    s = e + 1;
    e = e + k * (d + 1);
    V = reshape(vars(s : e), k, d + 1);
    
    val = 0;
    for it = 1 : size(pArray, 1)
        val = val + J(alpha, lambda, pArray(it), t(it, :), W, U, V, treeArray{it, 1}, vocab);
    end
    for pt = 1 : 1%size(pArray, 1)
        %pt
        p = pArray(pt);
        tree = treeArray{pt, 1};
        grad = zeros(e, 1);
        delta = sparse(size(vocab, 1), 1);
        %calculate dJ/dW
        array = {};
        array{numel(array) + 1} = p;
        ai = 1;
        gradIndex = 0;
        while(ai <= numel(array))
            curP = array{ai};
            ai = ai + 1;
            [c1, ~] = tree.getChildren(curP);
            if c1 ~= 0 
                for it = 1 : d
                    for jt = 1: 2 * d + 1
                        [grad(gradIndex + (it - 1) * d + jt), delta] = djByDW(it, jt, curP, W, U, V, t, delta, alpha, lambda, tree, vocab);
                    end
                end
            end
            [c1, c2] = tree.getChildren(curP);
            if(c1 ~= 0)
                array{numel(array) + 1} = c1;
                array{numel(array) + 1} = c2;
            end
        end

        %calculate dJ/dU
        array = {};
        array{numel(array) + 1} = p;
        ai = 1;
        while(ai <= numel(array))
            curP = array{ai};
            ai = ai + 1;
            [c1, c2] = tree.getChildren(curP);
            if c1 ~= 0 % Do not pass leaves for re-construction error
                for it = 1 : 2 * d
                    for jt = 1: d + 1
                        grad(gradIndex + (it - 1) * 2 * d + jt) = dJBydU(it, jt, curP, U, alpha, lambda, tree, vocab);
                    end
                end
            end
            [c1, c2] = tree.getChildren(curP);
            if(c1 ~= 0)
                array{numel(array) + 1} = c1;
                array{numel(array) + 1} = c2;
            end
        end
        gradIndex = gradIndex + d * (2 * d + 1);
        
        %Calculate dJ/dV
        array = {};
        array{numel(array) + 1} = p;
        ai = 1;
        while(ai <= numel(array))
            curP = array{ai};
            ai = ai + 1;
%             [c1, c2] = tree.getChildren(curP);
%             if c1 == 0
%                 break;
%             end
            for it = 1 : k
                for jt = 1: d + 1
                    grad(gradIndex + (it - 1) * k + jt) = djByDV(it, jt, curP, alpha, lambda, V, t, vocab, tree);
                end
            end
            [c1, c2] = tree.getChildren(curP);
            if(c1 ~= 0)
                array{numel(array) + 1} = c1;
                array{numel(array) + 1} = c2;
            end
        end
    end %End pt
end