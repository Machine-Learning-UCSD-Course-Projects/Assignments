function [ X,W,U,d,N ] = initialize_all()
    %As per Elkan, set d to 20
    d=20;
    
    %In this dataset, there are 5331 negative 
    %and 5331 positive reviews
    N=10662;
    
    %In this dataset 
    %Initialize [W b]
    W = rand(d,2d+1);
   
    %Initialize [U c]
    U = rand(2d+1,d);
    
    

end

