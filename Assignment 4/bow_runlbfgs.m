    options = [];
    %options.display = 'none';
    options.maxFunEvals = '100';
    %options.DerivativeCheck = 'on';
    d = 2;
    w = 14045;
    w_init = rand(w * d, 1) * 2 * 0.05 - 0.05;
    w_final = minFunc(@bow_LogisticReg, w_init, options, allSNum(1:2), labels, 2);
        