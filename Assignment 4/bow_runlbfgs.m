    options = [];
    %options.display = 'none';
    options.maxFunEvals = '100';
    %options.DerivativeCheck = 'on';
    d = 10;
    w = 14045;
    w_init = rand(w * d, 1) * 2 * 0.05 - 0.05;
    %train = allSNum{1:1024};
    %w_init = ones(w * d, 1);
    w_final = minFunc(@bow_LogisticReg, w_init, options, train, trainlabels, 2);
        