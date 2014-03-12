function val = dE2Bydx(i, xp, V, t)
    val = 0;
    %Classifier Error
    for jt = 1 : size(t, 2)
        val = val + (sm(V, xp', jt) - t(jt)) * V(jt, i);
    end
end