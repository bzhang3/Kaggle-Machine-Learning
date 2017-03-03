data = csvread('train.csv', 1,20, [1,20,200000,23]);
redata = csvread('train.csv', 1000001,20, [1000001,20,1010000,23]);
TrainData = [ReDataSet, data];
reTest = [TestDataMatrix, redata];
save TrainData.mat -v7.3
save reTest.mat -v7.3