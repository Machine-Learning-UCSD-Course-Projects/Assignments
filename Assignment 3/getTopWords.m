function words = getTopWords(phi, classicwordlist, topK)
    tempPhi = phi;
    words = cell(size(tempPhi, 1), topK);
    for i = 1:size(tempPhi, 1)
        for j = 1: topK
            [~, b] = max(tempPhi(i,:),[] ,2);
            tempPhi(i, b) = 0;
            words(i, j) = classicwordlist(b);
        end
    end
end