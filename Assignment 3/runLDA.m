if (exist('classic400') == 0)
    load classic400;
    V = size(classicwordlist, 1);
    M = size(classic400, 1);
end
K = 3;
if exist('q') == 0
    [ q, n, z ] = initializeLDA(M, K, V, classic400);
end
theta = doGibbsSampling(q, n, M, K, V, classic400, z);