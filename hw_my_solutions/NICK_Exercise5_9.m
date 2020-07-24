%Exercise 5.9

clc
clear all

data = importdata('hostpital.txt');
y = data(:,1);
X = data(:,2:size(data,2));
n = 12;

%Model of 10 independent variables
fprintf('=====================================================================================\n')
XX = [ones(n,1) X];
b = regress(y,XX);
yfit = XX*b;
e = y - yfit;
SSresid = sum(e.^2);
SStotal = (length(y)-1) * var(y);
rsq = 1 - SSresid/SStotal;
rsq_adj = 1 - SSresid/SStotal * (length(y)-1)/(length(y)-length(b)-1);
fprintf('Linear regression model:\ny ~ 1 + x1 + x2 + x3\n\n');
fprintf('Estimated Coefficients:\n\t(Intercept)\t %3.4f \n\tx1 %3.4f \n\tx2 %3.4f  \n\tx3',b(1),b(2),b(3),b(4));
fprintf('\nR-squared: %3.4f , Adjusted R-Squared %3.4f\nRoot Mean Squared Error: %3.4f\n\n', rsq,rsq_adj,std(e));


%fit linear models
fprintf('===========================================================================\n')
mdl1 = LinearModel.stepwise(X,y)
fprintf('===========================================================================\n')
mdl2 = LinearModel.stepwise(X,y,'interactions')
fprintf('===========================================================================\n')
mdl2 = LinearModel.stepwise(X,y,'linear')
fprintf('===========================================================================\n')
