function val = dJBydU(i, j, p, U, alpha, lambda, tree, vocab)
    [c1, c2] = tree.getChildren(p);
    xp = [vocab(p, :) 1];
    %xp = xp / norm(xp);
    x1 = vocab(c1, :);
    %x1 = x1 / norm(x1);
    x2 = vocab(c2, :);
    %x2 = x2 / norm(x2);
%     n1 = tree.getLeafCount(c1);
%     n2 = tree.getLeafCount(c2);
    ni = 1;%n1 / (n1 + n2);
    nj = 1;%n2 / (n1 + n2);
    d = size(x1, 2);
    z = U * xp';
    z(1:d) = z(1:d) / norm(z(1:d));
    z(d + 1 : 2 * d) = z(d + 1 : 2 * d) / norm(z(d + 1 : 2 * d));
    
    if i <= d
        val = -alpha * ni * 2 * (x1(i) - z(i)) * xp(j);
    else
        val = -alpha * nj * 2 * (x2(i - d) - z(i)) * xp(j);
    end
    val = val / size(tree.tree, 1) + lambda * U(i, j) / size(tree.tree, 1);
end