%% 5-1
%% Data
clc; clear all; close all;
M = 1000;
n = 20;
meanX = 0;
meanY = 0;
sigmaX = 1;
sigmaY = 1;
rho  = 0.5;
alpha = 0.05;
bins = floor(sqrt(M));
%% [c]
%n = 200;
%% [a,b]
fprintf('[a]\nCreating data with rho = %.2f\nCheck histograms\n',rho);
sigmaXY = sigmaX*sigmaY*rho;
%sigmaXY = sigmaX*sigmaY*rho^2; %[d]
r = NaN*ones(M,1);
for i=1:M
    data = mvnrnd([meanX meanY],[sigmaX^2 sigmaXY;sigmaXY sigmaY^2],n);
    X = data(:,1);
    Y = data(:,2);
    %X = X.^2; Y = Y.^2; %[d]
    temp = corrcoef(X,Y);
    r(i) = temp(1,2);
end

z = 0.5*log((1+r)./(1-r));
z_low = z-(norminv(1-alpha/2)*sqrt(1/(n-3)));
z_upper = z+(norminv(1-alpha/2)*sqrt(1/(n-3)));
r_low = tanh(z_low);
r_upper = tanh(z_upper);

H1 = NaN*ones(M,1);
H2 = NaN*ones(M,1);
t0 = r.*sqrt((n-2)./(1-r.^2));
for i=1:M
    %% Check if rho inside r's CI
    if rho<r_low(i) | rho>r_upper(i)
        H1(i) = 1;
    else
        H1(i) = 0;
    end
    %% Hypothesis Checking
    if t0(i)<-tinv(1-alpha/2,n-2) | t0(i)>tinv(1-alpha/2,n-2)
        H2(i) = 1;
    else
        H2(i) = 0;
    end
end

%% Answers
figure(1)
subplot(1,2,1)
hist(r_low,bins);
title('r - low value of CI')
subplot(1,2,2)
hist(r_upper,bins);
title('r - upper value of CI')
fprintf('rho insde r''s CI at %f%%\n',100*length(find(H1==0))/M);
fprintf('[b]\n Null hypothesis r=0 is accepted at %f%%\n',100*length(find(H2==0))/M);