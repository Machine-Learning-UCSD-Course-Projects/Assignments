function [ dx, dx2, delta ] = checkgrad(W, U, V, Truelabels, alpha, lambda, vocab, X, sentence_sizes, positive_sentences, negative_sentences)
    e = 1e-2;

    d = e;%.*sign(2.*rand(n,1)-1);
    dim = 20;
    [ T,Roots,vocab ] = buildAllTrees( X,W,U,sentence_sizes,1,dim,positive_sentences,negative_sentences,vocab);
    Nodes = T{1,1}.tree(:,2);
    Nodes = unique(Nodes);
    Nodes(1,:) = []; % Remove 0

    
    delta = zeros(size(vocab, 1), dim);
    
    dx = zeros(dim, 2 * dim + 1);
    dx1 = [];
    dx2 = [];
    tree = T{1, 1};

    
     
            p = Roots(1);
            queue = [];
            queue(1) = p;
            k = 1;
            delta = zeros(size(vocab, 1), dim);
            
            while(~isempty(queue))
                curP = queue(1);
                curP
                queue(1) = [];
                %[c1, c2] = tree.getChildren(curP);
                for it = 1 : 20
                    for jt = 1: 1
                    [ v, delta ] = djByDW(it, jt, curP, W, U, V, Truelabels(1,:), delta, alpha, lambda, T{1,1}, vocab);
                    dx(it, jt) = dx(it, jt) + v;
                    end
                end
                k = k + 1;

                [c1, c2] = tree.getChildren(curP);
                if c1 >= 270000
                    queue(end + 1) = c1;
                end;
                if c2 >= 270000
                    queue(end + 1) = c2;
                end
             
            end
            
           
            
            
  %for k = 1:size(Nodes)
      %p = Nodes(k);
      %k
      
       for i = 1:20
           i
           for j = 1:1
              temp = W(i, j);
              W(i,j) = temp + d;
              [ T,Roots,vocab ] = buildAllTrees( X,W,U,sentence_sizes,1,dim,positive_sentences,negative_sentences,vocab);
              p = Roots(1);
              dx1(i, j) = J(alpha, lambda, p, Truelabels(1,:), W, U, V, T{1,1}, vocab);
              W(i,j) = temp - d;
              [ T,Roots,vocab ] = buildAllTrees( X,W,U,sentence_sizes,1,dim,positive_sentences,negative_sentences,vocab);
              p = Roots(1);
              dx2(i, j) = (dx1(i, j) - J(alpha, lambda, p, Truelabels(1,:), W, U, V, T{1,1}, vocab)) / (2 * d);
              W(i,j) = temp;
           end;
       end;
  %end;