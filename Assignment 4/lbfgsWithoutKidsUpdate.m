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

function [W1, U1, V1] = lbfgsWithoutKidsUpdate(W, U, V, alpha, lambda, pArray, t, treeArray)
    options.Method = 'lbfgs';
    
    d = size(pArray(1), 1);
    k = size(t , 1);
    vars = zeros(d * (2 * d + 1) + (2 * d) * (d + 1) + k * (d + 1), 1);
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
    
    val = minFunc(@JForLbfgs, vars, options, alpha, lambda, pArray, t, treeArray);
    
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
function [val, grad] = JForLbfgs(vars, alpha, lambda, pArray, t, treeArray)
    d = size(pArray(1), 1);
    k = size(t , 1);
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
        val = val + J(alpha, lambda, pArray(it), t, W, U, V, treeArray(it));
    end
    for pt = 1 : size(pArray, 1)
        p = pArray(pt);
        tree = treeArray(pt);
        grad = zeros(e, 1);
        delta = zeros(d - 1, 1);
        ct = 1;
        %calculate dJ/dW
        array = {};
        array{numel(array) + 1} = p;
        ai = 1;
        while(1)
            curP = array{ai};
            ai = ai + 1;
            for it = 1 : d
                for jt = 1: 2 * d + 1
                    grad(ct) = djByDW(it, jt, curP, W, U, V, t, delta, alpha, tree);
                    ct = ct + 1;
                end
            end
            [c1, c2] = tree.getChildren(p);
            if c1 == 0
                break;
            else
                array{numel(array) + 1} = c1;
                array{numel(array) + 1} = c2;
            end
        end

        %calculate dJ/dU
        array = {};
        array{numel(array) + 1} = p;
        ai = 1;
        while(1)
            curP = array{ai};
            ai = ai + 1;
            for it = 1 : 2 * d
                for jt = 1: d + 1
                    grad(ct) = djByDU(it, jt, curP, alpha, tree);
                    ct = ct + 1;
                end
            end
            [c1, c2] = tree.getChildren(p);
            if c1 == 0
                break;
            else
                array{numel(array) + 1} = c1;
                array{numel(array) + 1} = c2;
            end
        end

        %Calculate dJ/dV
        array = {};
        array{numel(array) + 1} = p;
        ai = 1;
        while(1)
            curP = array{ai};
            ai = ai + 1;
            for it = 1 : k
                for jt = 1: d + 1
                    grad(ct) = djByDV(it, jt, curP, alpha, V, t);
                    ct = ct + 1;
                end
            end
            [c1, c2] = tree.getChildren(p);
            if c1 == 0
                break;
            else
                array{numel(array) + 1} = c1;
                array{numel(array) + 1} = c2;
            end
        end
    end %End pt
end