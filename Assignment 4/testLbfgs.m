tree = Tree(3);
tree.insert(1,3);
tree.insert(2,3);
d = 20;
k = 2;
vocab = randn(2, d);
W = randn(d, 2 * d + 1);
U = randn(2 * d, d + 1);
V = randn(k, d + 1);
vocab(3,:) = W * [vocab(1,:) vocab(2,:) 1]';

for i = 1 : 3
    vocab(i,:) = vocab(i,:) / norm(vocab(i));
end
t = cputime;
[W1, U1, V1] = lbfgsWithoutKidsUpdate(W, U, V, 0.1, 0.1, [3], [1 0], {tree}, vocab);
disp('Time:');
t = cputime - t