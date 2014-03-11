function val = djByDV(i, j, p, alpha, V, t)
    xp = [vocab(p), 1];
    val = (1 - alpha) * (sm(V, x, i) - t(i)) * xp(j);
end