function val = J(alpha, lambda, root, t, W, U, V)
    val = alpha * E1(root, U) + (1 - alpha) * E2(t, V, root) + lambda * (normOfTheta(W, U, V));
end

function val = E1(p, U)
    if isLeaf(p)
        val = 0;
        return;
    end
    [c1, c2] = getChildren(p);
    xp = [getVector(p), 1];
    x1 = getVector(c1);
    x2 = getVector(c2);
    d = size(x1);
    z = U * xp;
    n1 = getAllChildren(c1);
    n2 = getAllChildren(c2);
    ni = n1 / (n1 + n2);
    nj = n2 / (n1 + n2);
    val = ni * norm(x1 - z(1 : d)) + nj * norm(x2 - z(d + 1 : 2 * d)) + E1(c1, U) + E1(c2, U);
end

function val = E2(t, V, p)
    val = 0;
    xp = getVector(p);
    for i = 1:size(t)
        val = val + t(i) * log(sm(V, xp, i));
    end
    if isLeaf(p) == 0
        [c1, c2] = getChildren(p);
        val = E2(t, V, c1) + E2(t, V, c2);
    end
end

function val = normOfTheta(W, U, V)
    val = 0;
    for i = 1:size(W, 1)
        val = val + norm(W(i,:));
    end
    for i = 1:size(U, 1)
        val = val + norm(U(i,:));
    end
    for i = 1:size(V, 1)
        val = val + norm(V(i,:));
    end
end