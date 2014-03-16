    options = [];
    %options.display = 'none';
    options.maxFunEvals = '100';
    %options.DerivativeCheck = 'on';
    d = 2;
    w = 14045;
    w_init = rand(w * d, 1) * 2 * 0.05 - 0.05;
    %train = allSNum{1:9656};
    %w_init = ones(w * d, 1);
    w_final = minFunc(@bow_LogisticReg, w_init, options, allSNum, labels, 2);
        