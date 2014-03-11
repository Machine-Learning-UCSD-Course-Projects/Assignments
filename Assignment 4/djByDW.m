function val = djByDW(i, j, p, W, U, V, t, delta, alpha, tree)
    [c1, c2] = tree.getChildren(p);
    xp = vocab(p);
    d = size(xp);
    del = 0;
    x1 = vocab(c1);
    x2 = vocab(c2);
    n1 = tree.getLeafCount(c1);
    n2 = tree.getLeafCount(c2);
    ni = n1 / (n1 + n2);
    nj = n2 / (n1 + n2);
    z = U * xp;
    for it = 1:d
        delI = 0;
        %Classifier Error
        for jt = 1:size(t)
            delI = delI + (1 - alpha) * (sm(V, xp, jt) - t(jt)) * V(jt, it);
        end
        %Reconstruction Error
        delI = delI - alpha * ni * 2 * norm(x1 - z(1 : d)) * sum(U(1 : d, it));
        delI = delI -  alpha * nj * 2 * norm(x2 - z(d + 1 : 2 * d)) * sum(U(d + 1 : 2 * d, it));
        %Tree Error
        if size(p) ~= 0 %output
            parent = tree.getParent(p);
            [p1, ~] = tree.getChildren(parent);
            if p1 == p
                s = 1;
                e = d;
            else
                s = d + 1;
                e = 2 * d;
            end
            delI = delta(parent) * sum(W(s:e, it));
        end
        del = del + delI * hDash(W(it,:) * [x1, x2, 1]);
    end
    delta(p, it) = del;
    if j/d <= 1
        val = sum(delta(p,:)) * x1(i);
    else if j / d <= 2
            val = sum(delta(p,:)) * x2(i);
        else
            val = sum(delta(p,:));
        end
    end
end

function val = hDash(a)
    val = 1 - tanh(a) ^ 2;
end