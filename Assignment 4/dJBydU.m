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
    d = size(x1, 2);
    %should we use the norm or the difference?
    if i <= d
        val = -alpha * ni * 2 * (x1(i) - z(i)) * xp(j);
    else
        val = -alpha * nj * 2 * (x2(i - d) - z(i)) * xp(j);
    end
    val = val + lambda * U(i, j);
end
function val = dTheta(U)
    val = 0;
    for i = 1:size(U, 1)
        val = val + norm(U(i,:));
    end
end