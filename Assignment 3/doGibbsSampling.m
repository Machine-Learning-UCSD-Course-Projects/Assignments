function [theta, phi, n, nsum] = doGibbsSampling(q, n, M, K, V, classic400, z)
    p = zeros(K, 1);
    alpha = ones(K, 1);
    alpha(:) = 0.1;
    beta = ones(V, 1);
    beta(:) = 2;
    qsum = zeros(K, 1);
    nsum = zeros(M, 1);
    ITERATIONS = 100;
    
%     for i = 1:V
%         for j = 1:K
%             q(j, i) = q(j, i) + beta(i);
%         end
%     end
%     for m = 1:M
%         for j = 1:K
%             n(m, j) = n(m, j) + alpha(j);
%         end
%     end

    doc = cell(M, 1);
    for m = 1:M
        c = 1;
        doc{m} = zeros(sum(classic400(m, :)), 1);
        for t = 1:V
            for o = 1:classic400(m, t)
                doc{m}(c) = t;
                c = c + 1;
            end
        end
    end
    
    for j = 1:K
    %Optimization 3
    %((qsum(j) + sum(beta))
        qsum(j) = sum(q(j, :))+sum(beta);
    end
    
    for m = 1:M
    %Optimization 4
    %(nsum(m) + sum(alpha))
        nsum(m) = sum(n(m,:))+sum(alpha);
    end
    
    %Optimization 1
    %(q(j, doc{m}(i)) + beta(i))
    for row = 1:K
        q(row,:) = q(row,:)+beta';
    end
    
    %Optimization 2
    %(n(m, j) + alpha(j))
    for col = 1:K
        n(:,col) = n(:,col)+alpha(col);
    end
    for it = 1: ITERATIONS
        it
        for m = 1:M
            for i = 1:size(z{m}, 1)
                topic = z{m}(i);
                q(topic, doc{m}(i)) = q(topic, doc{m}(i)) - 1;
                n(m, topic) = n(m, topic) - 1;
                qsum(topic) = qsum(topic) - 1;
                nsum(m) = nsum(m) - 1;
              
                for j = 1:K
                    %INNER LOOP
                       p(j) = (q(j,doc{m}(i))*n(m, j))/(qsum(j) * nsum(m));
                end
                
                topic = randomTopic(p);
                q(topic, doc{m}(i)) = q(topic, doc{m}(i)) + 1;
                n(m, topic) = n(m, topic) + 1;
                qsum(topic) = qsum(topic) + 1;
                nsum(m) = nsum(m) + 1;
                z{m}(i) = topic;
            end
        end
    end
%     for m = 1:M
%         for j = 1:K
%             n(m, j) = n(m, j) - alpha(j);
%         end
%     end
%     for m = 1:M
%         nsum(m, 1) = sum(n(m,:));
%     end
    theta = getTheta(M, K, n, nsum);
    phi = getPhi(doc,M,K,V,z);
    
    theta
    phi
end

function phi = getPhi(doc,M,K,V,z)
    phi = ones(K,V);
    for k = 1:K  
        k
        for j=1:V
            j
            num = 0;
            den = 0;
            for m=1:M
                for i=1:size(doc{m})
                num = num + (doc{m}(i) == j && z{m}(i) == k);
                den = den + (z{m}(i) == k);                
                end
            end
            phi(k,j)=num/den;
        end
        %Sort the K rows of phi
        sort(phi(k,:),'descend');
    end
end

function topic = randomTopic(p)
    for j = 2:size(p)
        p(j) = p(j) + p(j - 1);
    end
    
    u = randi(100,1,1) * p(size(p)) / 100;
    
    for j = 1:size(p)
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

