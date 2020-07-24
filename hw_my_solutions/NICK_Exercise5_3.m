%% 5-2
%% Data
clc; close all; clear all;
temp = importdata('tempThes59_97.dat');
rain = importdata('rainThes59_97.dat');
[n p] = size(rain);
alpha = 0.05;
L = 1000;
months = {'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'};
%% Solution
H1 = NaN*ones(p,1);
H2 = NaN*ones(p,1);
r = NaN*ones(p,1);
positions = NaN*ones(12,1);
for i=1:p
    X = temp(:,i);
    Y = rain(:,i);
    r(i) = corr(X,Y);
    %% Hypothesis Testing
    t0 = abs(r(i)*sqrt((n-2)/(1-r(i)^2)));
    if( t0<-tinv(1-alpha/2,n-2) | t0>tinv(1-alpha/2,n-2)  )
        H(i) = 1;
    else
        H(i) = 0;
    end
    %% Randomization test
    t = ones(L,1);
    for j=1:L
        XX = randsample(X,n,false);
        t(j) = abs(corr(XX,Y)*sqrt((n-2)/(1-corr(XX,Y)^2)));
    end
    t = sort(t);
    [~,pos] = min(abs(t-t0));
    positions(i) = pos;
    if( pos<L*(alpha/2) | pos>L*(1-alpha/2) )
        H2(i)= 1;
    else
        H2(i) = 0;
    end
end
disp(['Parametric test [H1] ---> rain and temperature --- [0] Correlated --- [1] Not Correlated --- '])
disp(['Randomization test [H2] ---> rain and temperature --- [0] Correlated --- [1] Not Correlated ---'])
disp(['    [Month]  [H1]    [H2]      [r]     [position]'])
for i=1:1:12   
    disp([months(i),H(i),H2(i),r(i),positions(i)])
end