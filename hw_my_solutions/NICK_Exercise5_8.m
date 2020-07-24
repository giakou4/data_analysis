% 5-8
%% Data
clc; clear all; close all;
data = importdata('physical.txt');
y = data(:,1);
X = data(:,2:end);
[n p] = size(data);
%% Model of 10 independent variables
fprintf('=====================================================================================\n')
XX = [ones(n,1) X];
b = regress(y,XX);
yfit = XX*b;
e = y - yfit;
SSresid = sum(e.^2);
SStotal = (n-1) * var(y);
rsq = 1 - SSresid/SStotal;
rsq_adj = 1 - SSresid/SStotal * (n-1)/(n-length(b)-1);
fprintf('Linear regression model:\ny ~ 1 + x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10\n\n');
fprintf('Estimated Coefficients:\n\t(Intercept)\t %3.4f \n\tx1 %3.4f \n\tx2 %3.4f  \n\tx3 %3.4f \n\tx4 %3.4f \n\tx5 %3.4f  \n\tx6 %3.4f  \n\tx7 %3.4f  \n\tx8 %3.4f  \n\tx9 %3.4f  \n\tx10 %3.4f',b(1),b(2),b(3),b(4),b(5),b(6),b(7),b(8),b(9),b(10),b(11));
fprintf('\nR-squared: %3.4f , Adjusted R-Squared %3.4f\nRoot Mean Squared Error: %3.4f\n\n', rsq,rsq_adj,std(e));

%% fit linear models
fprintf('===========================================================================\n')
%mdl1 = LinearModel.stepwise(X,y)
[B,SE,PVAL,INMODEL,STATS,NEXTSTEP,HISTORY]=stepwisefit(X,y);