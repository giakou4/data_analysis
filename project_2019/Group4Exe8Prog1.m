%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
clc; clear all; close all;
data = importdata('forestfires.dat');
tittxt = str2mat('X','Y','month','day','FFMC','DMC','DC','ISI','temp','RH','rain','area');
[n,p] = size(data);
%% Data
M = 100;
nn = 40;
%% Create full data
% Take log of area (add min+1 cause area includes zeros)
data(:,p) = log(data(:,p) + min(data(:,p)) + 1);
y = data(:,11);
X = []
% Add my data to X and y
for i=1:p 
    if i~=11
        X = [X data(:,i)];
    end
end

%% Full model, all observations
[b,se,pval,inmodel,~,~,~] = stepwisefit(X,y);
%% Estimate model for less observations
inmodelArray = NaN*ones(M,p-1);
for i = 1:M
    idx = unidrnd(n,nn,1); 
    X2 = X(idx,:);
    y2 = y(idx);
    [~,~,~,inmodel2,~,~,~] = stepwisefit(X2,y2);
    for j=1:p-1 %transform boolean to integer
        if(inmodel2(j) == 1)
            inmodelArray(i,j) = 1;
        else
            inmodelArray(i,j) = 0;
        end
    end
end
%% Results
disp(['******************** RESULTS ********************']);
fprintf('All Data - Model includes:\n')
disp(inmodel)
fprintf('\nCreated %.0f samples of %.0f observations and:\n',M,nn)

for i=1:p-1
    temp = 100*length(find(inmodelArray(:,i)==0))/M;
    fprintf('[%.0f]Coefficient of %s is 0 at %.2f%%, initial was: %d\n',i,deblank(tittxt(i,:)),temp,inmodel(i))
end

%% Comments:
% Most of the times, the model of less observations includes 1-2
% parametres, so the frequency of '0's is very high. Lower
% frequencies  of '0's, which are around 70% match the '1' in the initial
% model.