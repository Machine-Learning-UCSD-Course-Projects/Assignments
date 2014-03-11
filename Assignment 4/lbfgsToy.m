function val = lbfgsToy()
    x = zeros(2, 1);
    options.Method = 'lbfgs';
    val = minFunc(@norm, x, options, [3,4], [5,6]);
end

function [val, grad]= norm(x, t, s)
    val = sin(x(1) * t(1) * s(1)) + cos(x(2) * t(2) * s(2));
    %if nargout>1
        grad = zeros(2, 1);
        grad(1) = t(1) * s(1) * cos(x(1)* t(1) * s(1));
        grad(2) = -t(2) * s(2) * sin(x(2));
    %end
end