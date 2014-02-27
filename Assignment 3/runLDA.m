% if (exist('classic400') == 0)
%     load classic400;
% V = size(classic400, 2);
% M = size(classic400, 1);
% end
clear
load('classic400.mat')

% CAREFUL
c = classic400;

V = size(c,2);
M = size(c,1);
<<<<<<< Updated upstream
K = 100;
=======
K = 100;%3, 10, 50, 100
>>>>>>> Stashed changes
if exist('q') == 0
    [ q, n, z ] = initializeLDA(M, K, V, classic400);
end
[theta, phi, n, nsum, unchangingZ,dominant_topics] = doGibbsSampling(q, n, M, K, V, classic400, z);

[a,trueLabelsCalc] = max(theta,[],2);
sum(trueLabelsCalc==1)
sum(trueLabelsCalc==2)
sum(trueLabelsCalc==3)

<<<<<<< Updated upstream
%NOTE : Value at index i in Phi corresponds to topic at index i in dominant_topics
save('k=100.mat')
=======
save('k=100.mat')%3, 10, 50, 100
>>>>>>> Stashed changes
