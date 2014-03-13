function val = sm(V, x, i)
     xp = [x 1]';
%     pi = exp(V(i,:) * xp);
%     sumpi = 0;
%     for j = 1:size(V, 1)
%         sumpi = sumpi + exp(V(j,:) * xp);
%     end
%     val = pi/sumpi;
    val = 1 / (1 + exp(-V(i,:) * xp));
end