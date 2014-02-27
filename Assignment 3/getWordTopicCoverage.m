function wordTopicCoverage = getWordTopicCoverage(phi)
    tempPhi = phi;
    wordTopicCoverage = zeros(size(tempPhi, 1), 1);
    for i = 1:size(tempPhi, 2)
        [~, b] = max(tempPhi(:,i),[] ,1);
        wordTopicCoverage(b) = wordTopicCoverage(b) + 1;
    end
end