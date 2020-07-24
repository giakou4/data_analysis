% 2-2
%% Data

clc; clear all; close all;
n = 1000;
tau = 1;
bins = floor(sqrt(n));
%% Solution

X = exprnd(tau,1000,1);

[Nx,Xy] = hist(X,bins);
ypdf = tau*exp(-tau*Xy);
ypdf = ypdf/sum(ypdf);

figure(1)
plot(Xy,Nx/n,'.-k')
hold on
plot(Xy,ypdf,'c')
legend('simulated','analytic')

figure(2)
histfit(X,bins,'exponential')