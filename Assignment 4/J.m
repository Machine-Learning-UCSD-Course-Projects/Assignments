function val = J(alpha, lambda, p, t, W, U, V, tree, vocab)
    val = (alpha * E1(p, U, tree, vocab) + (1 - alpha) * E2(t, V, p, tree, vocab)) / size(tree.tree, 1) + lambda * normOfTheta(W, U, V) / 2;
end

function val = E1(p, U, tree, vocab)
    [c1, c2] = tree.getChildren(p);
    if c1 == 0
        val = 0;
        return;
    end
    xp = [vocab(p, :), 1]';
    %xp = xp / norm(xp);
    x1 = vocab(c1, :);
    %x1 = x1 / norm(x1);
    x2 = vocab(c2, :);
    %x2 = x2 / norm(x2);
    d = size(x1, 2);
    z = U * xp;
    z(1:d) = z(1:d) / norm(z(1:d));
    z(d + 1 : 2 * d) = z(d + 1 : 2 * d) / norm(z(d + 1 : 2 * d));
    n1 = tree.getLeafCount(c1);
    n2 = tree.getLeafCount(c2);
    ni = 1;%n1 / (n1 + n2);
    nj = 1;%n2 / (n1 + n2);
    val = ni * norm(x1' - z(1 : d))^2 + nj * norm(x2' - z(d + 1 : 2 * d))^2 + E1(c1, U, tree, vocab) + E1(c2, U, tree, vocab);
end

function val = E2(t, V, p, tree, vocab)
    val = 0;
    [c1, c2] = tree.getChildren(p);
    if c1 == 0
        val = 0;
        return;
    end
    xp = vocab(p, :);
    xp = xp / norm(xp);
    for i = 1:size(t, 2)
        if t(i) == 1
            val = val - t(i) * log(sm(V, xp, i) + 0.0000001);
        else
            val = val - (1 - t(i)) * log(1 - sm(V, xp, i) + 0.0000001);
        end
    end
    if c1 ~= 0
        val = val + E2(t, V, c1, tree, vocab) + E2(t, V, c2, tree, vocab);
    end
end

function val = normOfTheta(W, U, V)
    val = 0;
    for i = 1:size(W, 1)
        for j = 1 : size(W, 2)
            val = val + W(i, j) ^ 2;
        end
    end
    for i = 1:size(U, 1)
        for j = 1 : size(U, 2)
            val = val + U(i, j) ^ 2;
        end
    end
    for i = 1:size(V, 1)
        val = val + norm(V(i,:)) ^ 2;
    end
end