% 3-2
%% Data
clc; clear all; close all;
n = 100;
M = 1000;
tau = 1;
bins = floor(sqrt(M));
%% [a] Solution
fprintf('Creating data from a exponential distribution with tau = %3.7f\n',tau);
X = exprnd(tau,n,1);
mleX = mle(X,'distribution','exponential');
fprintf('MLE of X is %3.7f\n',mleX);
meanX = mean(X);
fprintf('Mean of X is %3.7f\n',meanX);
clear X;clear meanX; clear mleX;
%% [b] Solution
X = poissrnd(tau,n,M);
meanX = mean(X);
[counts, centers] = hist(meanX,bins);
figure(1)
bar(centers,counts)
title([sprintf('Histogram of means of %.0f exponential samples with %.0f observations each',M,n)])
hold on
plot([tau tau],[0 1.1*max(counts)],'r')