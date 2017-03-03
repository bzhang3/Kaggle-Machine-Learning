load('TrainData.mat')
Data = TrainData;
%Beta = BetaCal(Data);
 n = size(Data(1,:));%22
 Data(:,20:22)=[];
 y = ones(n-3);
 % setting testing data
Cluster = reTest(:,22);
TrainCluster = TrainData(:,22);
reTesttest = reTest(:,1:19);
 
%% backward algorithm to select reasonable features
tempy = ones(200000,1);
for i = 1:200000
    tempy(i) = TrainCluster(i,1);
end
%Moore-Penrose pseudoinverse of input features
temp = (Data'*Data)^(-1)*Data' ;
Beta = temp * tempy;
Original = Beta'*Data'; 
%Row number of Data
m = size(Data(1,:));%22
S = std(Original);
%tempSD = ones(1,:);
tempSD = ones(m);

for i = 1:19
    tempData = Data;
    tempData(:,i) = [];
    tempBeta = (tempData'*tempData)^(-1)*tempData'*tempy;
    tempO = tempBeta'*tempData';
    tempSD(i) = std(tempO);
    y(i) = tempSD(i);
end

UpdateData = [Data TrainData(:,22)];

 element = 17;
for i = 1:element
   if y(i) > 14
       UpdateData(:,i) = [];
       reTesttest(:,i) = [];
       iter = iter -1;
   end
end

%%===========================================================
%% Learning Part

%Sort the matrix by hotel cluster
SortedData = sortrows(UpdateData, element);

%CluMatrix = zeros(100,1);
CluCenter = zeros(101,element-1);
T = 1; %row number
row = 1;
SortedData(200000,element);
Threshold = zeros(size(101,1));
Threshold(1,1) = 1;
i = 2;
while T 
   if  SortedData(row,element) ~= SortedData(row+1,element) 
       %each label cluster's cutoff row number
       Threshold(i,1) = row;
       i = i+1;
   end
   if row == 199999
       break
   end
   row = row +1;
end
Threshold(101,1) = 200000;
NonClusterMatrix = SortedData;
NonClusterMatrix(:,element)=[];
%Calculate the median of each label marix
for i = 2:101
    TempMatrix = NonClusterMatrix(Threshold(i-1,1):Threshold(i,1),:);
    CluCenter(i,:) = mean(TempMatrix);
%   CluCenter(i,:) = median(TempMatrix);
end
CluCenter(1,:) = [];
%%===========================================================
%% Preditor Part
% testing vector name: reTesttest
% cluster center vector: CluCenter
temp = zeros(100,2);
label = zeros(10000,1);
for i = 1:100
    temp(i,1) = i-1;
end

for iter = 1:10000
    for i = 1:100
       D = sqrt(sum(  (reTesttest(iter,:)-CluCenter(i,:)).^2)); 
       temp(i,2) = D;
    end
    Order = sortrows(temp, 2);
    label(iter,1) = Order(1,1);
end

%%===========================================================
%% Accuracy Check part
count = 0;
idx = kmeans(reTest,100);
for i = 1:10000
    if idx(i,1) == Cluster(i,1)
        count = count + 1;
    end
end
Accuracy = count/10000;
fprintf('Accuracy is: %f  \n', Accuracy*100);


%%===========================================================

 