% 3-8
%% Data
clc; clear all; close all;
n = 10;
M = 10000;
X = normrnd(0,1,n,M);
B = 1000;
bins = floor(sqrt(M));
alpha = 0.05;
%% [c]
%Y = exp(X);
%% [a] (i) Parametric CI
[~,~,CI1] = vartest(X,alpha);
%% [a] (ii) Bootstrap CI 
CI2 = bootci(B,{@var,X},'alpha',alpha);
%% [b] Check if (i) and (ii) "agree"
figure(1)
subplot(2,2,1)
hist(CI1(1,:),bins)
title('Parametric CI: low')
subplot(2,2,2)
hist(CI1(2,:),bins)
title('Parametric CI: upper')
subplot(2,2,3)
hist(CI2(1,:),bins)
title('Bootstrap CI: low')
subplot(2,2,4)
hist(CI2(2,:),bins)
title('Bootstrap CI: upper')