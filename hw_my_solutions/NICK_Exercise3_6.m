% 3-6
%% Data
clc; clear all; close all;
n = 10;
X = normrnd(0,1,n,1);
%Y = exp(X);
B = 1000;
bins = floor(sqrt(B));
%% [a]
bootmu = bootstrp(B,@mean,X);

figure(1)
hist(bootmu,bins);
title(['Histogram containing mean of ',num2str(B), ' boostrap samples'])
hold on
line([mean(X), mean(X)], ylim, 'LineWidth', 2, 'Color', 'r');
%% [b]
fprintf('Standard Error(se) of bootstrap mu is %3.3f\n',std(bootmu));
fprintf('Standard Deviation(std) of X is %3.3f\n',std(X));
fprintf('std(X)/sqrt(n) = %3.3f\n',std(X)/sqrt(n));
%assert se(X-bar) = std(X)/sqrt(n)