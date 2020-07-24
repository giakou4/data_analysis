%% [2] y=A*(x^B)
function [A,B,adjRsq2,e2] = FitIntrinsicallyLinear2(XX,YY)

if length(find(YY<=0))>0 | length(find(XX<=0))
    fprintf('Cannot fit y=A*exp(B*x)\n')
    A = NaN; B=NaN; adjRsq2 = NaN; return;
end

n = length(XX);

y = log(YY);
x = log(XX);

X = [ones(n,1) x];
b = X\y;

yfit = X*b;
e2 = y-yfit;
SSresid = sum(e2.^2);
SStotal = (n-1)*var(y);
adjRsq2 = 1 - SSresid/SStotal*(n-1)/(n-2);
Rsq2 = 1 - SSresid/SStotal;

A = exp(b(1));
B = b(2);

fprintf('Fitting y=A*(x^B), A=%.2f B=%.2f, adjR^2 = %f, R^2 = %f\n',A,B,adjRsq2,Rsq2)

end

