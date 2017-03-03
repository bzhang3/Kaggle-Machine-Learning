for i = 200000
CutoffDataSet = dataset(i,i,i);
end
CheckIn = zeros(size(CutoffDataSet(:,11:13)));
CheckOut = zeros(size(CutoffDataSet(:,14:16)));


CheckIn = abs(CutoffDataSet(:,11:13));
CheckOut = abs(CutoffDataSet(:,14:16));

NumberofData = size(CheckIn(:));
temp = zeros(size(CheckIn(:)));
NumberOfDays = zeros(size(CheckIn(:)));
for i = 1:NumberofData
    for j = 1:NumberofData
        for k = 1:NumberofData
    if (CheckIn(i) == CheckOut(i))
       %NumberOfDays(i) = CheckOut(:,:,i) - CheckIn(:,:,i);
        NumberOfDays(i) = 4;
    end
        end
    end 
end

%Days = DateTransfer(CheckIn, CheckOut);