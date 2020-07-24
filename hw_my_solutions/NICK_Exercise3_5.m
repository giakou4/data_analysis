% 3-5
%% Data
clc; clear all; close all;
X = importdata('eruption.dat');
% X(:,1): waiting time 1989
% X(:,2): duration 1989
% X(:,3): waiting time 2006
data_name = {'Waiting time 1989', 'Duration 1989', 'Waiting time 2006'};
alpha = 0.05;
teststd = [10 1 10]; %test values
testmu = [75 2.5 75]; %test values
[n p] = size(X);
%% [a]
fprintf('[a]\n');
for i=1:p
   [H,P,CI] =  vartest(X(:,i),teststd(i)^2,alpha);
   fprintf('%s:\n', data_name{i});
   fprintf('(1-%0.2f)%% CI for std is [%f %f]\n',alpha,sqrt(CI(1)),sqrt(CI(2)));
   fprintf('Hypothesis testing std=%f H=%.0f, p-value=%f\n\n',teststd(i),H,P);
end
%% [b]
fprintf('[b]\n');
for i=1:p
   [H,P,CI] =  ttest(X(:,i),testmu(i),alpha);
   fprintf('%s:\n', data_name{i});
   fprintf('(1-%0.2f)%% CI for mu is [%f %f]\n',alpha,CI(1),CI(2));
   fprintf('Hypothesis testing mu=%f H=%.0f, p-value=%f\n\n',testmu(i),H,P);
end
%% [c]
fprintf('[c]\n');
for i=1:p
   [H,P] = chi2gof(X(:,i),'cdf',@(z)normcdf(z,mean(X(:,i)),std(X(:,i))),'nparams',2);
   fprintf('%s:\n', data_name{i});
   fprintf('Goodnes-of-fit test: H=%.0f, p-value=%f\n',H,P);
end
%% [e]
fprintf('\n[e]\n');
I1 = find(X(:,2)<2.5); %indexes where duration<2.5
I2 = find(X(:,2)>2.5); %indexes where duration>2.5

X1 = X(I1,1); %waiting time when duration<2.5
X2 = X(I2,1); %waiting time when duration>2.5

fprintf('Mean waiting time when duration<2.5 equals %f += %f\n',mean(X1),std(X1))
fprintf('Mean waiting time when duration>2.5 equals %f += %f\n',mean(X2),std(X2))

if((mean(X1)+std(X1)>65 || mean(X1)-std(X1)>65) && (mean(X2)+std(X2)>91 || mean(X1)-std(X1)>91))
    fprintf('Statement is true\n');
else
    fprintf('Statement is false\n');
end