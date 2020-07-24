% 3-3
%% Data
clc; clear all; close all;
nn = [5 100];
M = 1000;
tau = 15;
alpha = 0.05;
%% Solution
n = 100;
fprintf('Creating %d obervations from exponential distribution with tau = %3.7f\n',n,tau);
X = exprnd(tau,n,1);
meanX = mean(X);
[~,~,CI] = ttest(X,alpha);
fprintf('Mean equals %f\n(1-%1.2f)%% CI for mean is: [%f %f]\n',meanX,alpha,CI(1),CI(2));
clear X; clear meanX; clear CI;
%% [a]
n = nn(1);
fprintf('[a]\nCreating %dx%d data from a exponential distribution with tau = %3.7f\n',n,M,tau);

X = exprnd(tau,n,M);
H = ttest(X,tau,alpha);

fprintf('Out of %.0f samples of %.0f observations: %f%% of the samples have tau=%.0f inside their (1-%f)%% CI\n',M,n,100*length(find(H==0))/M,tau,alpha);
%% [b]
n = nn(2);
fprintf('[b]\nCreating %dx%d data from a exponential distribution with tau = %3.7f\n',n,M,tau);

X = exprnd(tau,n,M);
H = ttest(X,tau,alpha);

fprintf('Out of %.0f samples of %.0f observations: %f%% of the samples have tau=%.0f inside their (1-%f)%% CI\n',M,n,100*length(find(H<0.5))/M,tau,alpha);