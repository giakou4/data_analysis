% 2-6
%% Data

clc; clear all; close all;
n = 100;
M = 10000;
bins = floor(sqrt(M));

%% Solution

X = unifrnd(0,1,n,M);
mu = mean(X);
histfit(mu,bins,'normal');
hold on
plot([mean(mu) mean(mu)], [0 400],'g');
legend('data','normal distribution','mean of means')