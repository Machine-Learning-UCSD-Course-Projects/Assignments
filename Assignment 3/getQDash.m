function qdash = getQDash(M, K, V, z, classic400)
    qdash = zeros(K, V);
    for m = 1:M
        c = 1;
        for t = 1:V
            for o = 1:classic400(m, t)
        %for t = 1:size(z{m}, 1)
            %qdash(z(t), t) = qdash(z(t), t) + classic400(m,t);
                qdash(z{m}(c), t) = qdash(z{m}(c), t) + 1;
                c = c + 1;
            end
        end
    end
end