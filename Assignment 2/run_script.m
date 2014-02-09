loadGlobals();

j = 1296;

%Input Sentence
x = [1 2 3 4 8];
xbar = x;
N = size(x,2);

%All the 8 tags
y = [1 2 3 4 5 6 7 8];
M = size(y,2);

%Weight vector
w = ones(1,j)*0.1;

%Compute all gi matrices
g = computeG(x, y, w);

%Compute alpha matrix
alpha = computeAlpha(M,N,g);

%Compute beta matrix
beta = computeBeta(M,N,g);

%Compute Z using alpha matrix
z1 = computeZ_usingAlpha(alpha,M,N);

%Compute Z using beta matrix
z2 = computeZ_usingBeta(beta,g,M);

%Sanity Check
if z1 - z2 > 1
    error('Z values are different');
end

%Initialize the actual Z
Z = z1;

%Calculate E
E = computeE(M,N,j,g,xbar,alpha,beta,Z);