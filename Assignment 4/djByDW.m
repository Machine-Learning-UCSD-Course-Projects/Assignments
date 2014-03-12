function val = djByDW(i, j, p, W, U, V, t, delta, alpha, lambda, tree, vocab)
    [c1, c2] = tree.getChildren(p);
    xp = vocab(p, :);
    d = size(xp, 2);
    del = 0;
    x1 = vocab(c1, :);
    x2 = vocab(c2, :);
    n1 = tree.getLeafCount(c1);
    n2 = tree.getLeafCount(c2);
    ni = n1 / (n1 + n2);
    nj = n2 / (n1 + n2);
    z = U * [xp 1]';
    smCached = zeros(size(t, 2), 1);
    for jt = 1:size(t, 2)
        smCached(jt) = sm(V, xp, jt);
    end
    
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
    end
    d1 = alpha * ni * 2 * norm(x1' - z(1 : d));
    d2 = alpha * nj * 2 * norm(x2' - z(d + 1 : 2 * d));
    for it = 1:d
        delI = 0;
        %Classifier Error
        for jt = 1:size(t, 2)
            delI = delI + (1 - alpha) * (smCached(jt) - t(jt)) * V(jt, it);
        end
        %Reconstruction Error
        delI = delI - d1 * sum(U(1 : d, it));
        delI = delI - d2 * sum(U(d + 1 : 2 * d, it));
        %Tree Error
        if(parent > 0)
            delI = delta(parent) * sum(W(it, s:e));
        end
        del = del + delI * hDash(W(it,:) * [x1, x2, 1]');
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
    val = val + lambda * normOfTheta(W);
end

function val = hDash(a)
    val = sech(a) ^ 2;
end

function val = normOfTheta(W)
    val = 0;
    for i = 1:size(W, 1)
        val = val + norm(W(i,:));
    end
end