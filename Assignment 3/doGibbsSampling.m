function [theta, n, nsum] = doGibbsSampling(q, n, M, K, V, classic400, z)
    p = zeros(V, K);
    alpha = ones(K, 1);
    alpha(:) = 0.1;
    beta = ones(V, 1);
    beta(:) = 1;
    qsum = zeros(K, 1);
    nsum = zeros(M, 1);
    ITERATIONS = 40;
    
    for i = 1:V
        for j = 1:K
            q(j, i) = q(j, i) + beta(i);
        end
    end
    for m = 1:M
        for j = 1:K
            n(m, j) = n(m, j) + alpha(j);
        end
    end
    
    for j = 1:K
        qsum(j) = sum(q(j, :));
    end
    for m = 1:M
        nsum(m) = sum(n(m,:));
    end
    for it = 1: ITERATIONS
        it
        for m = 1:M
            for i = 1:size(z{m}, 1)
                topic = z{m}(i);
                q(topic, i) = q(topic, i) - 1;
                n(m, topic) = n(m, topic) - 1;
                qsum(topic) = qsum(topic) - 1;
                nsum(m) = nsum(m) - 1;
                for j = 1:K
%                         p(i, j) = classic400(m, i) * (q(j, i) + beta(i)) * (n(m, j) + alpha(j)) / ...
%                             ((qsum(j) + sum(beta)) * (nsum(m) + sum(alpha)));
                        p(i, j) = q(j, i) * n(m, j)/ ...
                        (qsum(j) * nsum(m));
                end
                topic = randomTopic(p(i, :));
                q(topic, i) = q(topic, i) + 1;
                n(m, topic) = n(m, topic) + 1;
                qsum(topic) = qsum(topic) + 1;
                nsum(m) = nsum(m) + 1;
                z{m}(i) = topic;
            end
        end
    end
    for m = 1:M
        for j = 1:K
            n(m, j) = n(m, j) - alpha(j);
        end
    end
    for m = 1:M
        nsum(m, 1) = sum(n(m,:));
    end
    theta = getTheta(M, K, n, nsum);
end

function topic = randomTopic(p)
    for j = 2:size(p, 2)
        p(j) = p(j) + p(j - 1);
    end
    
    u = randi(100,1,1) * p(size(p, 2)) / 100;
    
    for j = 1:size(p, 2)
        if u < p(j)
            topic = j;
            return;
        end
    end
    topic = 1;
end

function theta = getTheta(M, K, n, nsum)
    theta = zeros(M, K);
    for m = 1:M
        for k = 1:K
            theta(m, k) = n(m, k) / nsum(m);
        end
    end
end

