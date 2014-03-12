function w = getTopicDocumentCoverage(trueLabelsCalc)
    w = zeros(3, 1);
    w(1, 1) = sum(trueLabelsCalc==1) / 400;
    w(2, 1) = sum(trueLabelsCalc==2) / 400;
    w(3, 1) = sum(trueLabelsCalc==3) / 400;
end