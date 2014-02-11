x = POS_TRAINING_SENTENCES(100,:);
x (x == 0) = [];
count = 0
for j = 1:numFeatureFunctions
    %for yiminus1=1:8
        %for yi=1:8
            for i=1:numel(x)
                %result = A(j, xbar, i) * B(j, yiminus1, yi);
                %result = computeFeatureFunction(j, yiminus1, yi, x, i);
                result = A(j, x, i);
                %result = B(j, yiminus1, yi);
                if result == 1
                    disp(j);
                    count = count + 1;
                end
            end
        %end
    %end
end
disp(count)