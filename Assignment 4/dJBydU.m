function val = dJBydU(i, j, p, U, alpha, lambda, tree, vocab)
    [c1, c2] = tree.getChildren(p);
    xp = [vocab(p, :), 1]';
    x1 = vocab(c1, :);
    x2 = vocab(c2, :);
    n1 = tree.getLeafCount(c1);
    n2 = tree.getLeafCount(c2);
    ni = n1 / (n1 + n2);
    nj = n2 / (n1 + n2);
    z = U * xp;
    d = size(xp, 2);
    %should we use the norm or the difference?
    if i <= size(x1)
        val = -alpha * ni * 2 * norm(x1' - z(1 : d)) * xp(j);
    else
        val = -alpha * nj * 2 * norm(x2' - z(d + 1 : 2 * d)) * xp(j);
    end
    val = val + lambda * dTheta(U);
end
function val = dTheta(U)
    val = 0;
    for i = 1:size(U, 1)
        val = val + norm(U(i,:));
    end
end