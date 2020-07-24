% 3-4
%% Data
clc; clear all; close all;
X = [41 46 47 47 48 50 50 50 50 50 50 50 ...
        48 50 50 50 50 50 50 50 52 52 53 55 ...
        50 50 50 50 52 52 53 53 53 53 53 57 ...
        52 52 53 53 53 53 53 53 54 54 55 68];
alpha = 0.05;
teststd = 5;
testmu = 52;

%% [a,b]
[H,P,CI] = vartest(X,teststd^2,alpha);
fprintf('[a,b]\n(1-%.2f)%% CI for variance is [%f %f]\n',alpha,CI(1),CI(2));
fprintf('Null hypothesis std=%f:H=%.0f | p-value=%f\n',teststd,H,P);
%% [c,d]
[H,P,CI] = ttest(X,testmu,alpha);
fprintf('[c,d]\n(1-%.2f)%% CI for mean is [%f %f]\n',alpha,CI(1),CI(2));
fprintf('Null hypothesis mu=%f:H=%.0f | p-value=%f\n',testmu,H,P);
%% [e]
[H,P] = chi2gof(X,'cdf',@(z)normcdf(z,mean(X),std(X)),'nparams',2);
fprintf('[e]\nGoodnes-of-fit test: H=%.0f, p-value=%f\n',H,P);