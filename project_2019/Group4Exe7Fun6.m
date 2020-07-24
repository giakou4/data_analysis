function [b,yfit,e,adjRsq] = FitLinear(x,y,K)

n = length(x);
b = polyfit(x,y,K);
yfit = polyval(b,x);
e = y-yfit;
SSresid = sum(e.^2);
SStotal = (n-1)*var(y);
adjRsq = 1 - SSresid/SStotal*(n-1)/(n-K-1);
Rsq = 1 - SSresid/SStotal;
fprintf('Fitting Linear Poly degree %.0f, adjR^2 = %f, R^2 = %f\n',K,adjRsq,Rsq)

end
