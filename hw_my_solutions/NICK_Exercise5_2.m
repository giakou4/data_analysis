%% 5-2
%% Data
clc; clear all; close all;
n = 200;
L = 100;
alpha = 0.05;
M = 1000;
rho = 0.9;
sigmaX = 1;
sigmaY = 1;
meanX = 0;
meanY = 0;
%% Randomization Hypothesis Testing
sigmaXY = sigmaX*sigmaY*rho;
H = NaN*ones(M,1);
fprintf('Creating samples with rho = %f\n',rho);
for i=1:M
    data = mvnrnd([meanX meanY],[sigmaX^2 sigmaXY;sigmaXY sigmaY^2],n);
    X = data(:,1);
    Y = data(:,2);
    r = corr(X,Y);
    t0 = r*sqrt((n-2)/(1-r^2));
    t = NaN*ones(L,1);
    for j=1:L
        XX = randsample(X,n,false);
        rr = corr(XX,Y);
        t(j) = rr*sqrt((n-2)*(1-rr^2));
    end
    t = sort(t);
    [~,pos] = min(abs(t-t0));
    if pos<L*alpha/2 | pos>L*(1-alpha/2)
        H(i) = 1;
    else
        H(i) = 0;
    end
end
fprintf('M=%.0f samples with L=%.0f randomizations to check if r=0.\nAccept null hypothesis rho=0 at %2.2f%%\n',...
    M,L,100*length(find(H==0))/M);