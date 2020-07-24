% 3-10
%% Data
clc; clear all; close all;
M = 100;
n = 10;
m = 12;
X = normrnd(0,1,n,M);
Y = normrnd(0,1,m,M);
B = 100;
bins = floor(sqrt(M));
alpha = 0.05;
replacement = true;
%% [a] (iii) Randomization Hypothesis Testing
%replacement = false;
%% [a] (i) Parametric Hypothesis Testing
[H1,~,~] = ttest2(X,Y,alpha);
fprintf('[a]\nHypothesis Testing Parametric: accept null hypothesis %f%%\n',100*length(find(H1==0))/M)
%% [a] (ii) Bootstrap Hypothesis Testing 
H2 = NaN*ones(1,M);
for j=1:1:M
    XY = [X(:,j);Y(:,j)]; %1 column, m+n rows
    bootstrapxy =  NaN*ones(1,B);
    for k=1:1:B
        bootstrap_samples = randsample(XY,m+n,replacement);
        x_mean = mean(bootstrap_samples(1:n));
        y_mean = mean(bootstrap_samples(n+1:n+m));
        bootstrapxy(k) = x_mean - y_mean;
    end
   bootstrapxy = sort(bootstrapxy);
   [~,r] = min(abs(bootstrapxy-(mean(X(:,j))-mean(Y(:,j)))));

   if(r< ( (B+1)*alpha )/2 | r>(B+1)*(1-alpha/2))
       H2(j) = 1; %reject null hypothesis
   else
       H2(j) = 0; %accept null hypothesis
   end
   
end
if replacement == true
    fprintf('[b]\nHypothesis Testing Bootstrap: accept null hypothesis %f%%\n',100*length(find(H2==0))/M);
else
    fprintf('[c]\nHypothesis Testing Randomization: accept null hypothesis %f%%\n',100*length(find(H2==0))/M);
end