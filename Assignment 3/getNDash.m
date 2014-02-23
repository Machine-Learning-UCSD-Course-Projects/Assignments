function ndash = getNDash(M, K, V, z, classic400)
    ndash = zeros(M, K);
    for m = 1:M
        %for t = 1:V
        for t = 1:size(z{m}, 1)
            %ndash(m, z(t)) = ndash(m, z(t)) + classic400(m, t);
            ndash(m, z{m}(t)) = ndash(m, z{m}(t)) + 1;
        end
    end
end