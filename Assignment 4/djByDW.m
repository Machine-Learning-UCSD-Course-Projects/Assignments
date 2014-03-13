function [val, delta]= djByDW(i, j, p, W, U, V, t, delta, alpha, lambda, tree, vocab)
    [c1, c2] = tree.getChildren(p);
    xp = vocab(p, :);
    xp = xp / norm(xp);
    d = size(xp, 2);
    x1 = vocab(c1, :);
    x1 = x1 / norm(x1);
    x2 = vocab(c2, :);
    x2 = x2 / norm(x2);
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
            delI = delI + (1 - alpha) * (sm(V, xp, jt) - t(jt)) * V(jt, i);
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
            [p1, ~] = tree.getChildren(parent);
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
    val = val + lambda * W(i, j);
end

function val = hDash(a)
    val = sech(a) ^ 2;
end