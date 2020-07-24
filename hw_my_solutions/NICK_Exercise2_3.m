% 2-3
%% Data 

clc; clear all; close all;
n = 1000;
muX = 1;
muY = 2;
sigmaX = 1;
sigmaY = 2;
rho = 0.5;
%% Solution

sigmaXY = rho*sigmaX*sigmaY;

data = mvnrnd([muX muY],[sigmaX^2 sigmaXY;sigmaXY sigmaY^2],n);
X = data(:,1);
Y = data(:,2);

fprintf('Var(X+Y)=%7.3f\n',var(X+Y));
fprintf('Var(X)+Var(Y)=%7.3f + %7.3f = %7.3f\n',var(X),var(Y),var(X)+var(Y));