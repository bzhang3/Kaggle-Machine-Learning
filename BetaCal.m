function Beta = BetaCal(Data)

y = ones(200000,1);
%Moore-Penrose pseudoinverse of input features
temp = (Data'*Data)^(-1)*Data' ;

Beta = temp * y;

end