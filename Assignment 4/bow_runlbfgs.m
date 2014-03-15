    options = [];
    options.display = 'none';
    options.maxFunEvals = '100';

    w_init = ones(14045 * 2, 1);
    w_final = minFunc(@bow_LogisticReg, w_init, options, allSNum, labels, 2);
        