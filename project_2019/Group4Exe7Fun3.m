%% [3] y=a+b*log(x)
function [A,B,adjRsq3] = FitIntrinsicallyLinear3(XX,YY)

if length(find(XX<=0))
    fprintf('Cannot fit y=A*exp(B*x)\n')
    A = NaN; B=NaN; adjRsq3 = NaN; return;
end

n = length(XX);

y = YY;
x = log(XX);

X = [ones(n,1) x];
b = X\y;

yfit = X*b;
e3 = y-yfit;
SSresid = sum(e3.^2);
SStotal = (n-1)*var(y);
adjRsq3 = 1 - SSresid/SStotal*(n-1)/(n-2);
Rsq3 = 1 - SSresid/SStotal;

A = b(1);
B = b(2);

fprintf('Fitting y=A+B*log(x), A=%.2f B=%.2f, adjR^2 = %f, R^2 = %f\n',A,B,adjRsq3,Rsq3)
end

