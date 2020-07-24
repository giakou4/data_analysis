%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
clc; clear all; close all;
data = importdata('forestfires.dat');
[n p] = size(data);
tittxt = str2mat('X','Y','month','day','FFMC','DMC','DC','ISI','temp','RH','wind','rain','area');
%% Data
K = 5; %max poly degree to test;
%% Solution
% deleteoutliers = Group04Exe7Fun5;
% FitIntrinsicallyLinear1 = Group04Exe7Fun1;
% FitIntrinsicallyLinear2 = Group04Exe7Fun2;
% FitIntrinsicallyLinear3 = Group04Exe7Fun3;
% FitIntrinsicallyLinear4 = Group04Exe7Fun4;
% FitLinear = Group04Exe7Fun6;
warning off

iter = find(data(:,p)~=0);
data = data(iter,:);
[n p] = size(data);

% Take log of area (add min+1 cause area includes zeros)
data(:,p) = log(data(:,p) + min(data(:,p)) + 1);

for i=1:p-1
    display(['**********************************************************'])
    disp(['area VS ',deblank(tittxt(i,:))]);
    display(['**********************************************************'])
    [~,~,~] = Group4Exe7Fun1((data(:,i)),(data(:,p)));
    [~,~,~] = Group4Exe7Fun2((data(:,i)),(data(:,p)));
    [~,~,~] = Group4Exe7Fun3((data(:,i)),(data(:,p)));
    [~,~,~] = Group4Exe7Fun4((data(:,i)),(data(:,p)));
    for k=1:K
        [~,~,adjRsq] = Group4Exe7Fun6((data(:,i)),(data(:,p)),k);   
    end
end
        
    

