function val = djByDV(i, j, p, alpha, lambda, V, t, vocab)
    xp = vocab(p, :);
    extendedXp = [xp 1];
    val = (1 - alpha) * (sm(V, xp, i) - t(i)) * extendedXp(j);
    val = val + lambda * dTheta(V);
end
function val = dTheta(V)
    val = 0;
    for i = 1:size(V, 1)
        val = val + norm(V(i,:));
    end
end