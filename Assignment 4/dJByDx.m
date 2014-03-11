% function val = dJByDx(i, p, U, alpha, t, V, delta)
%     parent = getParent(p);
%     [c1, ~] = getChildren(parent);
%     z = U * [getVector(p) 1];
%     if c1 == p
%         z = z(1 : d);
%     else
%         z = z(d + 1 : 2 * d);
%     end
%     val = alpha * (2 * norm(p - z));
%     sTrem = 0;
%     for jt = 1 : size(t)
%         sTrem = sTrem + (sm(V, p, jt) - t(jt)) * V(jt, i);
%     end
%     val = val + (1 - alpha) * sTerm + delta(parent);
% end
function val = dJByDx(i, p, t, V)
    val = 0;
    xp = vocab(p);
    for jt = 1 : size(t)
        val = val + (sm(V, xp, jt) - t(jt)) * V(jt, i);
    end
end