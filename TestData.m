CutoffDataSet = dataset(1000001:1010000,:);

%% Days Calcuation
CheckIn = abs(CutoffDataSet(:,11:13));
CheckOut = abs(CutoffDataSet(:,14:16));

m = 10000;

Days = zeros(size(CheckIn(:,1)));

InYear = CheckIn(:,1);
OutYear = CheckOut(:,1);

InMonth = CheckIn(:,2);
OutMonth = CheckOut(:,2);

InDay = CheckIn(:,3);
OutDay = CheckOut(:,3);

for iter = 1:m
    if InYear(iter) == OutYear(iter) && InMonth(iter) == OutMonth(iter)
        Days(iter) = OutDay(iter) - InDay(iter); 
    else
            if InMonth(iter) == 1 || InMonth(iter) == 3 || InMonth(iter) == 5 || InMonth(iter) == 7 || ...
                    InMonth(iter) == 7 || InMonth(iter) == 8 || InMonth(iter) == 8 || InMonth(iter) == 12 
                temp1 = 31 - InDay(iter);
                  
            elseif InMonth(iter) == 4 || InMonth(iter) == 6 || InMonth(iter) == 9 || InMonth(iter) == 11
                temp1 = 30 - InDay(iter);
                        
            else
                temp1 = 28 - InDay(iter);
            end
            
            Days(iter) = temp1 + OutDay(iter);
    end      
end
%%=============================================================================
%% Resize matrix 

TestDataMatrix = [CutoffDataSet(:,1:10) Days(:) CutoffDataSet(:,17:23)];

%%=============================================================================
save TestDataMatrix.mat -v7.3
