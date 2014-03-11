% function val = lbfgsKidsUpdate()
%     x = zeros(2, 1);    
%     val = minFunc(@norm, x);
% end
% 
% function [val, grad]= norm(x)
%     val = sin(x(1)) + cos(x(2));
%     if nargout>1
%         grad = zeros(2, 1);
%         grad(1) = cos(x(1));
%         grad(2) = -sin(x(2));
%     end
% end
function val = lbfgsKidsUpdate()
end