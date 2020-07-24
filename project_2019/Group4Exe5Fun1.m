%% [1] y=A*exp(B*x)
function [A,B,adjRsq1,e1] = FitIntrinsicallyLinear1(XX,YY)

if length(find(YY<=0))>0
    fprintf('Cannot fit y=A*exp(B*x)\n')
    A = NaN; B=NaN; adjRsq1 = NaN; return;
end

n = length(XX);

y = log(YY);
x = XX;

X = [ones(n,1) x];
b = X\y;

yfit = X*b;
e1 = y-yfit;
SSresid = sum(e1.^2);
SStotal = (n-1)*var(y);
adjRsq1 = 1 - SSresid/SStotal*(n-1)/(n-2);
Rsq1 = 1 - SSresid/SStotal;

A = exp(b(1));
B = b(2);

fprintf('Fitting y=A*exp(B*x), A=%.2f B=%.2f, adjR^2 = %f, R^2 = %f\n',A,B,adjRsq1,Rsq1)


end

