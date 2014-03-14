function [val, delta]= djByDW(i, j, p, W, U, V, t, delta, alpha, lambda, tree, vocab)
    [c1, c2] = tree.getChildren(p);
    xp = vocab(p, :);
    %xp = xp / norm(xp);
    d = size(xp, 2);
    x1 = vocab(c1, :);
    %x1 = x1 / norm(x1);
    x2 = vocab(c2, :);
    %x2 = x2 / norm(x2);
    n1 = tree.getLeafCount(c1);
    n2 = tree.getLeafCount(c2);
    ni = 1;%n1 / (n1 + n2);
    nj = 1;%n2 / (n1 + n2);
    z = U * [xp 1]';
    z(1:d) = z(1:d) / norm(z(1:d));
    z(d + 1 : 2 * d) = z(d + 1 : 2 * d) / norm(z(d + 1 : 2 * d));
    %for it = 1:d
        delI = 0;
        %Classifier Error
        for jt = 1:size(t, 2)
            smt = sm(V, xp/norm(xp), jt);
            delI = delI + (1 - alpha) * 0.5 * (smt - t(jt)) * V(jt, i);
        end
        %Reconstruction Error
        %if(i <= d)
            delI = delI - alpha * 2 * ni * (U(1 : d, i))' * (x1' - z(1 : d));
        %else
            delI = delI - alpha * 2 * nj * (U(d + 1 : 2 * d, i))' * (x2' - z(d + 1 : 2 * d));
        %end
        %Tree Error
        parent = tree.getParent(p);
        if parent ~= 0 %not output
            [p1, p2] = tree.getChildren(parent);
            xparent = vocab(parent, :);
            xparent = xparent / norm(xparent);
            z = U * [xparent 1]';
            z(1:d) = z(1:d) / norm(z(1:d));
            z(d + 1 : 2 * d) = z(d + 1 : 2 * d) / norm(z(d + 1 : 2 * d));
            xp1 = vocab(p1, :);
            xp1 = xp1 / norm(xp1);
            xp2 = vocab(p2, :);
            xp2 = xp2 / norm(xp2);
            if i <= d
                delI = delI + alpha * 2 * ni * (x1(i) - z(i));
            else
                delI = delI + alpha * 2 * nj * (x2(i) - z(i + d));
            end
            
            if p1 == p
                s = 1;
                e = d;
            else
                s = d + 1;
                e = 2 * d;
            end
            delI = delI + W(i, s : e) * delta(parent, :)';
            %delI = delI + delta(parent) * sum(W(i, s:e));
        end
    %end
%     if j <= d
%         delta(p, i) = delI * hDash(W(i, j) * x1(i));
%     else
%         delta(p, i) = delI * hDash(W(i, j) * x2(i));
%     end
    delta(p, i) = delI * hDash(W(i, :) * [x1 x2 1]');
    if j <= d
        val = delta(p, i) * x1(j);
    else if j <= 2 * d
            val = delta(p, i) * x2(j - d);
        else
            val = delta(p, i);
        end
    end
    val = val / size(tree.tree, 1) + lambda * W(i, j) / size(tree.tree, 1);
end

function val = hDash(a)
    val = sech(a) ^ 2;
end