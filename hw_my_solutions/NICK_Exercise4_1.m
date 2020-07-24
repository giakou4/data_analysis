% 4-1
%% Data
clc; clear all; close all;
E = 0.76;
alpha = 0.05;
M = 1000;
%% [a]
h1 = 100;
h2 = [60 54 58 60 56];

e = sqrt((1/h1)*h2);
n = length(e);
precision = std(e);
accuracy = mean(e) - e;
fprintf('[a]\nRandom uncertainty for next observation: mean(e)+-tcrit*std(e) or %f +- %f\n',...
    mean(e),tinv(1-alpha/2,n-1)*std(e));
fprintf('Random uncertainty for mean: mean(e)+-tcrit*std(mean) or %f +- %f\n',...
    mean(e),tinv(1-alpha/2,n-1)*std(e)/sqrt(n));
%% [b]
h1 = 100;
h2 = normrnd(58,2,5,M);

meanh2= mean(h2);
stdh2 = std(h2);
figure(1)
subplot(1,2,1)
hist(meanh2);
title(sprintf('mean of h_2 for %.0f samples',M))
subplot(1,2,2)
hist(stdh2);
title(sprintf('std of h_2 for %.0f samples',M))

e = sqrt((1/h1).*h2);
meane = mean(e);
stde = std(e);
figure(2)
subplot(1,2,1)
hist(meane);
title(sprintf('mean of e for %.0f samples',M))
subplot(1,2,2)
hist(stde);
title(sprintf('std of e for %.0f samples',M))

H = ttest(e,E,alpha);
fprintf('[b]\nOut of %.0f samples, data are consistent %f%%\n',M,100*length(find(H==0))/M)
%% [c]
h1 = [80 100 90 120 95]';
h2 = [48 60 50 75 56]';

e = sqrt(h2 ./ h1);
h1sd = std(h1);
h1mean = mean(h1);
h2sd = std(h2);
h2mean = mean(h2);
esd = std(e);
emean = mean(e);

% First (simple) approach: h1 and h2 are assumed to be independent
esigma = sqrt((-0.5*sqrt(h2mean)*h1mean^(-3/2))^2*h1sd^2 + ...
    (0.5*sqrt(1/h1mean)*sqrt(1/h2mean))^2*h2sd^2);
fprintf('[c]\nstd computed from transformed data: %2.5f \n',esd);
fprintf('std from transformed SD (assume independence): %2.5f \n',esigma);
% Second approach: h1 and h2 are assumed to be dependent to each other
tmp =  corrcoef(h1,h2);
r = tmp(1,2);
h1h2covar = h1sd * h2sd * r;
esigma2 = sqrt((-0.5*sqrt(h2mean)*h1mean^(-3/2))^2*h1sd^2 + ...
    (0.5*sqrt(1/h1mean)*sqrt(1/h2mean))^2*h2sd^2 + ...
    2*(-0.5*sqrt(h2mean)*h1mean^(-3/2))*(0.5*sqrt(1/h1mean)*sqrt(1/h2mean))*h1h2covar);
fprintf('std from transformed SD (assume dependence): %2.5f \n',esigma2);

H = ttest(e,E,alpha);
disp(['Null hypothesis:accept ball H=',num2str(H)])