% 3-1
%% Data
clc; clearall; close all;
n = 100;
M = 1000;
lamda = 1;
bins = floor(sqrt(M));
%% [a]
fprintf('Creating data from a poisson distribution with lamda = %3.7f\n',lamda);
X = poissrnd(lamda,n,1);
mleX = mle(X,'distribution','poisson');
fprintf('MLE of X is %3.7f\n',mleX);
meanX = mean(X);
fprintf('Mean of X is %3.7f\n',meanX);
clear X;clear meanX; clear mleX;
%% [b]
X = poissrnd(lamda,n,M);
meanX = mean(X);
[counts, centers] = hist(meanX,bins);
figure(1)
bar(centers,counts)
title([sprintf('Histogram of means of %.0f poisson samples with %.0f observations each',M,n)])
hold on
plot([lamda lamda],[0 1.1*max(counts)],'r')