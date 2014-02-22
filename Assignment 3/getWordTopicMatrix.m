function w = getWordTopicMatrix(K, V)
    w = zeros(V, 1);
    for t = 1:V
        w(t) = randi(K,1,1);
    end
end