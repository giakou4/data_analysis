% Exercise 6-2
%% Data
clc, clear all, close all

X = importdata('yeast.dat');
[n p] = size(X);
%% [a] PCA 
[coeff,score,~,~,explained,mu] = pca(zscore(X)); % Default is SVD
%% [b] estimate d<p
sum_explained = 0;
idx = 0;
while sum_explained < 95
    idx = idx + 1;
    sum_explained = sum_explained + explained(idx);
end

display(['The first components that explain more than 95% of all variability: d=',num2str(idx)]);

%% [c] Plot PC scores in R2 and R3
figure(1)
plot(score(:,1),score(:,2),'.');
title('PC scores in R^2')
xlabel('PC1');
ylabel('PC2');

figure(2)
plot3(score(:,1),score(:,2),score(:,3),'.')
title('PC scores in R^3')
xlabel('PC1');
ylabel('PC2');
zlabel('PC3');