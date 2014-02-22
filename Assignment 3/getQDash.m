function qdash = getQDash(M, K, V, z, classic400)
    qdash = zeros(K, V);
    for m = 1:M
        for t = 1:V
            qdash(z(t), t) = qdash(z(t), t) + classic400(m,t);
        end
    end
end