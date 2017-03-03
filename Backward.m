function output = Backward(Data)
    y = ones(200000,1);
    %Moore-Penrose pseudoinverse of input features
    temp = (Data'*Data)^(-1)*Data' ;
    Beta = temp * y;
    Original = Beta'*Data'; 
    %Row number of Data
    m = size(Data(1,:));%22
    S = std(Original);
    %tempSD = ones(1,:);
    for i = 1:m
        tempData = Data;
        tempData(:,i) = [];
        
        tempBeta = (tempData'*tempData)^(-1)*tempData'*y;
        
        tempSD(i) = std(tempBeta'*tempData');
        output(i) = tempSD(i);
end
    
  
     
 
end
