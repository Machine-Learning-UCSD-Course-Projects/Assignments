classdef Tree < handle
    properties (SetAccess = private)
      tree;
      c;
    end
    methods
        function obj = Tree(n)
            obj.tree = zeros(n, 2);
            obj.c = 1;
        end
        
        function insert(obj, ch, p)
            obj.tree(obj.c,:)  = [ch, p];
            obj.c = obj.c + 1;
        end
        
        function [left,right] = getChildren(obj,p)
            %Find all indices of element p in 2nd column
            ind = find(obj.tree(:,2)==p);
            
            if numel(ind) > 1
                %Get left child
                left = obj.tree(ind(1),1);            
                %Get right child
                right = obj.tree(ind(2),1);
            else
                left = 0;
                right = 0;
            end
        end
        
        function val = getLeafCount(obj,p)            
            [l,r] = obj.getChildren(p);
            val = 0;
            if l==0 && r==0
                val = 1;
            else                
                val = val + obj.getLeafCount(l);
                val = val + obj.getLeafCount(r);
            end            
        end
        
        function parent = getParent(obj,p)
            %TODO:Add the case where p is root node : p will only occur in 2nd
            %column.
            i = find(obj.tree(:,1) == p);
            if size(i, 1) == 0
                parent = 0;
                return;
            end
            
            parent = obj.tree(i(1), 2);
        end
        
    end
end