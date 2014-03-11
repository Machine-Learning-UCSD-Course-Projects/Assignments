function val = dJBydU(i, j, p, alpha)
    [c1, c2] = getChildren(root);
    xp = getVector(p);
    xp = [getVector(p), 1];
    x1 = getVector(c1);
    x2 = getVector(c2);
    n1 = getAllChildren(c1);
    n2 = getAllChildren(c2);
    ni = n1 / (n1 + n2);
    nj = n2 / (n1 + n2);
    %should we use the norm or the difference?
    if i <= size(x1)
        val = -alpha * ni * 2 * norm(x1 - z1) * xp(j);
    else
        val = -alpha * nj * 2 * norm(x2 - z2) * xp(j);
    end
end