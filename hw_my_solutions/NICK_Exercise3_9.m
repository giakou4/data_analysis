% 3-9
%% Data
clc; clear all; close all;
M = 100;
n = 10;
m = 12;
X = normrnd(0,1,n,M);
Y = normrnd(0,1,m,M);
B = 1000;
bins = floor(sqrt(M));
alpha = 0.05;
%% [c]
%Y = normrnd(0.2,1,m,M);
%% [a] (i) Parametric CI
[~,~,CI1] = ttest2(X,Y,alpha);
%% [a] (ii) Bootstrap CI 
CI2 = NaN*ones(2,M);
for i=1:1:M
    bootstatX = bootstrp(B, @mean, X(:,i));
    bootstatY = bootstrp(B, @mean, Y(:,i));
    bootstatXY = bootstatX - bootstatY;
    bootstatXY = sort(bootstatXY);
    k = floor((B+1)*alpha/2);
    CI2(1,i) = bootstatXY(k);
    CI2(2,i) = bootstatXY(B+1-k);
end
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