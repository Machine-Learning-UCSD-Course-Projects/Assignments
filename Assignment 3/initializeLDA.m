function [ q, n, z] = initializeLDA(M, K, V, classic400)
    z = getWordTopicMatrix(K, V);
    q = getQDash( M, K, V, z, classic400);
    n = getNDash(M, K, V, z, classic400);
end

