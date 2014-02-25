% if (exist('classic400') == 0)
%     load classic400;
% V = size(classic400, 2);
% M = size(classic400, 1);
% end
clear
load('hookah10k.mat')

% CAREFUL
classic400=c;

V = size(c,2);
M = size(c,1);
K = 10;
if exist('q') == 0
    [ q, n, z ] = initializeLDA(M, K, V, classic400);
end
[theta, phi, n, nsum] = doGibbsSampling(q, n, M, K, V, classic400, z);

[a,trueLabelsCalc] = max(theta,[],2);
sum(trueLabelsCalc==1)
sum(trueLabelsCalc==2)
sum(trueLabelsCalc==3)
