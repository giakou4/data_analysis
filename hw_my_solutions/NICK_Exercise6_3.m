% Exercise 6-3
%% Data
clc, clear all, close all
X = importdata('physical.txt');
XX = X(:,2:11);
[n p] = size(XX);
vbls = {'Fore','Bicep','Chest','Neck','Shoulder','Waist','Height','Calf','Thigh','Head'};
%% [a] PCA
[coeff,score,latent,~,explained,mu] = pca(zscore(XX)); % Default is SVD
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