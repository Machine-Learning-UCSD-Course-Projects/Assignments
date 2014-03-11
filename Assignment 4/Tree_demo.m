t=Tree(7);
t.insert(1,3);
t.insert(2,3);

t.insert(4,1);
t.insert(5,1);

t.insert(6,2);
t.insert(7,2);

t.getLeafCount(3) %Should equal 4

%load('codeDataMoviesEMNLP/data/rt-polaritydata/rt-polarity_neg_binarized.mat','allSNum');
%n=allSNum;
% for i = 1:5331
%     sentence=n{1,i};
%     if sum(sentence<0)>0
%         disp('fuck up')
%         disp(i)
%     end
% end

