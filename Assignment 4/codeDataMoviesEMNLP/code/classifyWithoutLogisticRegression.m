
theta = opttheta;

[W1, W2, W3, W4, b1, b2, b3, Wcat,bcat, We] = getW(1, theta, params.embedding_size, cat_size, dictionary_length);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Get features by forward propagating and finding structure for all train and test sentences...')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% in this setting, we take the top node's vector and the average of all vectors in the tree as a concatenated feature vector

[fulltraining_instances, wordsTraining, phrasesTraining, phraseVectorsTraining] = getFeatures(allSNum(train_ind),0,...
    We,We2,W1,W2,W3,W4,b1,b2,b3,Wcat,bcat,params.alpha_cat,params.embedding_size, ...
    labels(:,train_ind), freq_train, func, func_prime, params.trainModel);

[fulltesting_instances, wordsTest, phrasesTest, phraseVectorsTest] = getFeatures(allSNum(test_ind),0,...
    We,We2,W1,W2,W3,W4,b1,b2,b3,Wcat,bcat,params.alpha_cat,params.embedding_size,...
    labels(:,test_ind), freq_test, func, func_prime, params.trainModel);

training_labels = labels(:,train_ind)';
testing_labels = labels(:,test_ind)';

fulltraining_instances = fulltraining_instances(:,:,1);
[t1 t2 t3] = size(fulltraining_instances);
training_instances = reshape(fulltraining_instances,t1, t2*t3);
fulltesting_instances = fulltesting_instances(:,:,1);
[t1 t2 t3] = size(fulltesting_instances);
testing_instances = reshape(fulltesting_instances,t1,t2*t3);


[num_training_instances ~] = size(training_instances);
[num_testing_instances ~] = size(testing_instances);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Logistic regression
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialize parameters
theta2 = -0.5+rand(t3*params.embedding_size*cat_size + cat_size,1);

options2.Method = 'lbfgs';
options2.maxIter = 1000;

% Training
% [theta2, cost] = minFunc( @(p) soft_cost(p,training_instances, training_labels, 1e-6),theta2, options2);
% b = theta2(end);
% W = theta2(1:end-1)';

dec_val = sigmoid(Wcat*training_instances' + bcat(:,ones(num_training_instances,1)));
pred = 1*(dec_val > 0.5);
gold = training_labels';
[prec_train, recall_train, acc_train, f1_train] = getAccuracy(pred, gold);

% Testing
dec_val = sigmoid(Wcat*testing_instances' + bcat(:,ones(num_testing_instances,1)));
pred = 1*(dec_val > 0.5);
gold = testing_labels';
[prec_test, recall_test, acc_test, f1_test] = getAccuracy(pred, gold);

acc_train
acc_test

%for i = 1:size(wordsTraining, 1)
    dec_val = [(1 : size(wordsTraining, 1));  sigmoid(Wcat*wordsTraining' + bcat(:,ones(size(wordsTraining, 1),1)))]';
%end
dec_val = sortrows(dec_val, -2);
top10PositiveWordsTraining = dec_val(1: 10, :);
dec_val = sortrows(dec_val, 2);
top10NegativeWordsTraining = dec_val(1: 10, :);

%for i = 1:size(wordsTest, 1)
    dec_val = [(1 : size(wordsTest, 1));  sigmoid(Wcat*wordsTest' + bcat(:,ones(size(wordsTest, 1),1)))]';
%end
dec_val = sortrows(dec_val, -2);
top10PositiveWordsTest = dec_val(1: 10, :);
dec_val = sortrows(dec_val, 2);
top10NegativeWordsTest = dec_val(1: 10, :);

%for i = 1:size(phraseVectorsTraining, 1)
    dec_val = [(1 : size(phraseVectorsTraining, 1));  sigmoid(Wcat*phraseVectorsTraining' + bcat(:,ones(size(phraseVectorsTraining, 1),1)))]';
%end
dec_val = sortrows(dec_val, -2);
top10PhrasesTrainingPositive = phrasesTraining{dec_val(1 : 10, 1)};
dec_val = sortrows(dec_val, -2);
top10PhrasesTrainingNegative = phrasesTraining{dec_val(1 : 10, 1)};

%for i = 1:size(phraseVectorsTest, 1)
    dec_val = [(1 : size(phraseVectorsTest, 1));  sigmoid(Wcat*phraseVectorsTest' + bcat(:,ones(size(phraseVectorsTest, 1),1)))]';
%end
dec_val = sortrows(dec_val, -2);
top10PhrasesTestPositive = phrasesTraining{dec_val(1 : 10, 1)};
dec_val = sortrows(dec_val, -2);
top10PhrasesTestNegative = phrasesTraining{dec_val(1 : 10, 1)};

fid = fopen('../output/resultsRAE.txt','a');
fprintf(fid,[num2str(params.CVNUM),',',num2str(1),',',num2str(params.embedding_size),',',num2str(params.lambda(1)),',' , ...
    ',num2str(params.alpha_cat),' , num2str(options2.MaxIter)]);

fprintf(fid,',train,%f,%f,%f,%f',acc_train, prec_train, recall_train, f1_train);
fprintf(fid,',test,%f,%f,%f,%f\n',acc_test, prec_test, recall_test, f1_test);
fclose(fid);
