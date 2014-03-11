function val = djByDV(i, j, p, alpha, V, t)
    xp = [getVector(p), 1];
    val = (1 - alpha) * (sm(V, x, i) - t(i)) * xp(j);
end