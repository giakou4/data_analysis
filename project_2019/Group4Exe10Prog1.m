%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
clc; clear all; close all;
%% Data (can change)
perc = 0.80; %percentage of training set
dmin = 3; %minimum dimension reduction
dmax = 11; %maximum dimension reduction
%% Data
data = importdata('forestfires.dat');
[n P] = size(data);
y = data(:,10); %RH
X = data(:,[1:9 11:P]);
ntrain = floor(perc*n);
neval = n - ntrain;
XTRAIN = X(1:ntrain,:);
XEVAL = X(ntrain+1:end,:);
YTRAIN = y(1:ntrain);
YEVAL = y(ntrain+1:end);
SStotal = sum( (YEVAL-mean(YEVAL)).^2 );
dmin=floor(dmin);dmax=floor(dmax);
if(dmin<1)dmin=1;end
if(dmax>11)dmax=11;end
%% Full Model
b = regress(YTRAIN,[ones(ntrain,1) XTRAIN]);
yfit = [ones(neval,1) XEVAL]*b;
e = YEVAL - yfit;
SSresid = sum(e.^2);
Rsq = 1 - SSresid/SStotal;

figure(1)
clf
scatter(YEVAL,YEVAL);
Legend=cell(2+8+8,1);
Legend{1} = strcat('data');
hold on
plot(YEVAL,yfit,'+r')
Legend{2} = strcat('full model');
disp('*******************************************************************')
fprintf('Full Model\t\tRsq=%f\t\tstd(e)=%f\n',Rsq,std(e))
legendIter = 3;
%% Reduced Model 1 - PLS
disp('*******************************************************************')
%bPLSarray = [];
%bPLSarray2 = [];
for d=dmin:dmax
    [~,~,~,~,bPLS,PCTVAR,MSE,STATS] = plsregress(XTRAIN,YTRAIN,d);
    %bPLSarray2 = [bPLSarray2 bPLS];
    %[~,iter] = mink(abs(bPLS),P-1-p);
    %bPLS(iter) = 0;
    %bPLSarray = [bPLSarray bPLS];
    yfitPLS = [ones(neval,1) XEVAL]*bPLS;
    e = YEVAL - yfitPLS;
    SSresid = sum(e.^2);
    Rsq = 1 - SSresid/SStotal;
    figure(1)
    hold on
    plot(YEVAL,yfitPLS,'x','color',rand(1,3))
    Legend{legendIter} = strcat('PLS d=',num2str(d));
    legendIter = legendIter + 1;
    fprintf('PLS d=%.0f\t\tRsq=%f\t\tstd(e)=%f\n',d,Rsq,std(e))
end
%% Reduced Model 2 - PCR
disp('*******************************************************************')
%bPCRarray = [];
%bPCRarray2 = [];
for d = dmin:dmax
    [PCALoadings,PCAScores,~,~,explained,~] = pca(XTRAIN,'Economy',false);
    bPCR = regress(YTRAIN-mean(YTRAIN), PCAScores(:,1:d));
    bPCR = PCALoadings(:,1:d)*bPCR;
    bPCR = [mean(YTRAIN) - mean(XTRAIN)*bPCR; bPCR];
    %bPCRarray2 = [bPCRarray bPCR];
    %[~,iter] = mink(abs(bPCR),P-1-d);
    %bPCR(iter) = 0;
    %bPCRarray = [bPCRarray bPCR];
    yfitPCR = [ones(neval,1) XEVAL]*bPCR;
    e = YEVAL - yfitPCR;
    SSresid = sum(e.^2);
    Rsq = 1 - SSresid/SStotal;
    figure(1)
    hold on
    plot(YEVAL,yfitPCR,'s','color',rand(1,3))
    Legend{legendIter} = strcat('PCR with d=',num2str(d));
    legendIter = legendIter + 1;
    fprintf('PCR d=%.0f\t\tRsq=%f\t\tstd(e)=%f\n',d,Rsq,std(e))   
end
disp('*******************************************************************')
fprintf('d: dimension reduction\n');
legend(Legend)
%% Comments
% Note that if Rsq is negative , which indicates a bad prediction since
% SSresid > SStotal, Rsq becomes zero.
% In this Program, we applied PLS and PCR and kept more and more parametres
% from 4 to 11. Results can be seen in Command Window.