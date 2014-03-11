function val = sm(V, x, i)
    pi = exp(V(i,:) * x);
    sumpi = 0;
    for j = 1:sizeo(V, 1)
        sumpi = sumpi + exp(V(j,:) * x);
    end
    val = pi/sumpi;
end