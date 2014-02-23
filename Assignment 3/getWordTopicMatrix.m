function z = getWordTopicMatrix(M, K, V, classic400)
    z = cell(M, 1);
    for m = 1:M
        c = 1;
        z{m} = zeros(sum(classic400(m, :)), 1);
        for t = 1:V
            for o = 1:classic400(m, t)
                z{m}(c) = randi(K,1,1);
                c = c + 1;
            end
        end
    end
end