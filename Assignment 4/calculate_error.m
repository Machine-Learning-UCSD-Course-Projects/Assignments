function [ E ] = calculate_error(U,X,Xk,k_sizes,N,d)
%CALCULATE_ZI_ZJ 
    E = cell(N,1);
    
    for sentence=1:N
        %Init empty array to store all E values for a sentence
        error = zeros(k_sizes(sentence),1);

        for k=1:k_sizes(sentence)
            %[zi;zj] = U*Xk + c
            Z = U*cell2mat(Xk(sentence,k));
            
            %Split [zi;zj] into Zi and Zj
            Zi = Z(1:d);
            Zj = Z(d+1:2*d);
            
            %Compute i and j from k
            i = k;
            j = k+1;
            
            %Pull Xi and Xj form X
            Xi = cell2mat(X(sentence,i));
            Xj = cell2mat(X(sentence,j));
            
            %Calculate error
            %Equation used 
            error(k,1) = dot(Xi-Zi,Xi-Zi) + dot(Xj-Zj,Xj-Zj);
        end
        E(sentence) = {error};
    end
end

