%% [4] y=A+B*(1/x)
function [A,B,adjRsq4,e4] = FitIntrinsicallyLinear4(XX,YY)

if length(find(XX==0))
    fprintf('Cannot fit y=A*exp(B*x)\n')
    A = NaN; B=NaN; adjRsq4 = NaN; return;
end

n = length(XX);
y = YY;
x = 1./XX;

X = [ones(n,1) x];
b = X\y;

yfit = X*b;
e4 = y-yfit;
SSresid = sum(e4.^2);
SStotal = (n-1)*var(y);
adjRsq4 = 1 - SSresid/SStotal*(n-1)/(n-2);
Rsq4 = 1 - SSresid/SStotal;

A = b(1);
B = b(2);

fprintf('Fitting y=A+B*(1/x), A=%.2f B=%.2f, adjR^2 = %f, R^2 = %f\n',A,B,adjRsq4,Rsq4)

end

