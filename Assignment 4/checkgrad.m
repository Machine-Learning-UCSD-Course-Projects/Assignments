function [ dx, dx1, dx2, delta ] = checkgrad(W, U, V, Roots, Truelabels, alpha, lambda, T, vocab)
    e = 1e-6;

    d = e;%.*sign(2.*rand(n,1)-1);


    Nodes = T{1,1}.tree(:,2);
    Nodes = unique(Nodes);
    Nodes(1,:) = []; % Remove 0

    delta = zeros(size(vocab, 1), 1);

    dx = [];
    dx1 = [];
    dx2 = [];
    tree = T{1, 1};

    dim = 20;
  
    for it = 1 : dim
        for jt = 1: 2 * dim + 1
            p = Roots(1);

            queue = [];
            queue(1) = p;
            k = 1;

            while(~isempty(queue))
                curP = queue(1);
                disp(curP)
                queue(1) = [];
                [c1, c2] = tree.getChildren(curP);
                [ dx(k, it, jt), delta ] = djByDW(it, jt, curP, W, U, V, Truelabels(1,:), delta, alpha, lambda, T{1,1}, vocab);
                disp(k)
                k = k + 1;

                [c1, c2] = tree.getChildren(curP);
                if c1 >= 270000
                    queue(end + 1) = c1;
                end;
                if c2 >= 270000
                    queue(end + 1) = c2;
                end
            end
        end
    end
  
  for k = 1:size(Nodes)
      p = Nodes(k);
      k
      for i = 1:size(W,1)
          for j = 1:size(W,2)
              temp = W(i, j);
              W(i,j) = temp + d;
              dx1(k, i, j) = J(alpha, lambda, p, Truelabels(1,:), W, U, V, T{1,1}, vocab);
              W(i,j) = temp - d;
              dx2(k, i, j) = J(alpha, lambda, p, Truelabels(1,:), W, U, V, T{1,1}, vocab);
              W(i,j) = temp;
          end;
      end;
  end;