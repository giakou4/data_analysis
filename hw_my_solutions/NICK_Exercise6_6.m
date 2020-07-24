% 6-6
%% Data 
clc; clear all; close all;
data = importdata('physical.txt');
y = data(:,1);
X = data(:,2:end);
clear data;
meanY = mean(y);
meanX = mean(X);
[n p] = size(X);
%% Ridge Regression
k = 0:1e-3:5e-1;
bRRv = ridge(y,X,k,0);

figure(2)
clf
plot(k,bRRv(2:end,:),'LineWidth',2)
ylim([-10 10])
grid on 
xlabel('Ridge Parameter') 
ylabel('Standardized Coefficient') 
title('Ridge Trace') 

idx = -1;
bRR = bRRv(:,1);
yfitRR = [ones(n,1) X]*bRR;
for i=1:length(k)
    yfittemp = [ones(n,1) X]*bRRv(:,i);
    if(sum(sqrt(y-yfittemp)) < sum(sqrt(y-yfitRR)))
        bRR = bRRv(:,i);
        yfitRR = yfittemp;
        idx = i;
    end
end

fprintf('Ridge Regression: b=[')
fprintf(' %.2f ',bRR)
fprintf(']\n')

figure(1)
clf
hold on
plot(y,y,'k')
hold on
plot(y,yfitRR,'xg')
%%  LASSO
[bLASSOv FitInfo] = lasso(X,y,'CV',10);
idxLambdaMinMSE = FitInfo.IndexMinMSE;

%figure(3)
lassoPlot(bLASSOv,FitInfo,'PlotType','CV');
legend('show')

bLassoIntercept = FitInfo.Intercept(idxLambdaMinMSE);
bLASSO = bLASSOv(:,idxLambdaMinMSE);
fprintf('LASSO: b=[')
fprintf(' %.2f %.2f',bLassoIntercept,bLASSO)
fprintf(']\n')

yfitLASSO = bLassoIntercept + X*bLASSO;

figure(1)
hold on
plot(y,yfitLASSO,'xr')
%% PLS
[~,~,~,~,bPLS,PCTVAR] = plsregress(X,y,p);

fprintf('PLS: b=[')
fprintf(' %.2f ',bPLS)
fprintf(']\n')

figure(4)
plot(1:p,cumsum(100*PCTVAR(2,:)),'-bo');
xlabel('Number of PLS components');
ylabel('Percent Variance Explained in y');
title('PLS')

figure(5)
yfitPLS = [ones(n,1) X]*bPLS;
residuals = y - yfitPLS;
stem(residuals)
xlabel('Observation');
ylabel('Residual');
title('PLS')

figure(1)
hold on
plot(y,yfitPLS,'xb')
%% OLS
[U S V] = svd(X-repmat(sum(X)/n,n,1),'econ');
bOLS = V*(S\U'*(y-meanY));

fprintf('OLS to detrended data: b=[')
fprintf(' %.2f ',bOLS)
fprintf(']\n')

yfitOLS = X*bOLS-meanY;


figure(1)
hold on
plot(y,yfitOLS,'xc')
%% PCR
[PCALoadings,PCAScores,~,~,explained,~] = pca(X,'Economy',false);

sum_explained = 0;
idx = 0;
while sum_explained < 95
    idx = idx + 1;
    sum_explained = sum_explained + explained(idx);
end
fprintf('PCR: Dim. reduction to %.0f\n',idx)

bPCR = regress(y-mean(y), PCAScores(:,1:idx));
bPCR = PCALoadings(:,1:idx)*bPCR;
bPCR = [mean(y) - mean(X)*bPCR; bPCR];
yfitPCR = [ones(n,1) X]*bPCR;

fprintf('PCR: b=[')
fprintf(' %.2f ',bPCR)
fprintf(']\n')

figure(1)
hold on
plot(y,yfitPCR,'xm')
legend('real','RR','LASSO','PLS','OLS','PCR')