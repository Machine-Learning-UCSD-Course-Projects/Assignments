function val = djByDV(i, j, p, alpha, lambda, V, t, vocab, tree)
    xp = vocab(p, :);
    extendedXp = [xp/norm(xp) 1];
    val = (1 - alpha) * (sm(V, xp, i) - t(i)) * extendedXp(j);
    val = val / size(tree.tree, 1) + lambda * V(i, j) / size(tree.tree, 1);
end