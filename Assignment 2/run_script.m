%Input Sentence
x = [1 2 3 4 8];
N = size(x,2);

%All the 8 tags
y = [1 2 3 4 5 6 7 8];
M = size(y,2);

%Weight vector
w = ones(1,5)*0.1;

%Compute all gi matrices
g = computeG(x, y, w);

%Compute alpha matrix
alpha = computeAlpha(M,N,g);

%Compute beta matrix
beta = computeBeta(M,N,g);

%Compute Z using alpha matrix
z1 = computeZ_usingAlpha(alpha,N);

%Compute Z using beta matrix
z2 = computeZ_usingBeta(beta,g,M);

