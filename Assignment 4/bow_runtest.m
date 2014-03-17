d = 10;
V(1,:) = w_final(1:d)';
V(2,:) = w_final((d+1):(2*d))';
predlabel = [];
for i = 1:size(train,1)
    X = zeros(d, 1);
    for j = 1:size(train{i}, 2)
        x_start = train{i}(j);
        x_start = (x_start + 1) * d + 1;
        X = X + w_final(x_start:(x_start + d - 1));
    end;
    X = X / j;
    predlabel(i,:) = 1/(1 + exp(-V * X));
end;
disp(i)
[ m, arg ] = max(predlabel');
arg = arg - 1;
sum(abs(trainlabels - arg))