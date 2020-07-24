%% 4-3
% P = V*I*cos(f)
%% Data
clc; clear all; close all;
M = 1000;
sV = 0.71;
sI = 0.071;
sf = 0.017;
meanV = 77.28;
meanI = 1.21;
meanf = 0.283;
rhoVf = 0.5;
%% [a] P = V*I*cos(f) 
sP = sqrt(  (sV^2)*(meanI^2)*(cos(meanf)^2) + (sI^2)*(meanV^2)*(cos(meanf)^2) + (sf^2)*(meanI^2)*(meanV^2)*(sin(meanf)^2)  );
fprintf('[a]\nExpected sP = %f\n',sP)
%% [b] 
meanP = meanV*meanI*cos(meanf);
V = normrnd(77.78,0.71,1,M);
I = normrnd(1.21,0.071,1,M);
f = normrnd(0.283,0.017,1,M);
P = V.*I.*cos(f);
stdP = std(P);
fprintf('[b]\nCalculated sP from sample: std(P) = %f\n',stdP);
%% [c]
sVf = rhoVf*sV*sf;
mean_matrix = [meanV meanI meanf];
covariance_matrix = [sV^2   0     sVf;...
                    0      sI^2     0;...
                    sVf     0     sf^2];
VIf2 = mvnrnd(mean_matrix,covariance_matrix,M);
V2 = VIf2(:,1);
I2 = VIf2(:,2);
f2 = VIf2(:,3);
P2 = V2.*I2.*cos(f2);
sP2 = sP + 2*(meanI*cos(meanf))*(meanV*meanI*sin(meanf))*sVf;
stdP2 = std(P2);
fprintf('[c]\nExpected sP = %f\nCalculated sP from sample: std = %f\n',sP2,stdP);