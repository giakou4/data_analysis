%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
%% Data
clc; clear all; close all;
data = importdata('forestfires.dat');
[n p] = size(data);
tittxt = str2mat('X','Y','month','day''FFMC','DMC','DC','ISI','temp','RH','wind','rain','area');
alpha = 0.05;
nn = 40;
B = 1000;
replacement = true;
%% Create my small sample
idx = unidrnd(n,nn,1);
data2 = data(idx,:);
%% Check if r~=0 - Parametric
disp(['********** Parametric test: r=0 from a small sample **********']);
r1 = NaN*ones(p,p);
H1 = NaN*ones(p,p);
for i=5:p-1
    for j=i+1:p-1
        r1(i,j) = corr(data2(:,i) - mean(data2(:,i)),data2(:,j) - mean(data2(:,j)));
        t0 = abs(r1(i,j)*sqrt((nn-2)/(1-r1(i,j)^2)));
        if t0<-tinv(1-alpha/2,nn-2) | t0 > tinv(1-alpha/2,nn-2)
            fprintf('No correlation between %s and %s\n',deblank(tittxt(i,:)),deblank(tittxt(j,:)));
            H1(i,j) = 1;
        else
            fprintf('Correlation r=%f between %s and %s\n',r1(i,j),deblank(tittxt(i,:)),deblank(tittxt(j,:)));
            H1(i,j) = 0;
        end
    end
end
%% Check if r~=0 - Bootstrap
disp([' '])
disp(['********** Bootstrap test: r=0 from a small sample **********']);
H2 = NaN*ones(p,p);
for i=5:p-1 %for each combination
    for j=i+1:p-1
        rboot = NaN*ones(B,1);
        xboot = data2(:,i) - mean(data2(:,i)); %data to check
        yboot = data2(:,j) - mean(data2(:,j)); %data to check
        for k=1:B %do B bootstrap 
        xboot2 = randsample(xboot,nn,'false'); %take a random sample of 1st data
        rboot(k) = corr(xboot2,yboot);
        end
        rboot = sort(rboot);
        [~,pos] = min(abs(rboot-r1(i,j)));
        if pos<(B+1)*alpha/2 | pos>(B+1)*(1-alpha/2)
            fprintf('No correlation between %s and %s\n',deblank(tittxt(i,:)),deblank(tittxt(j,:)));
            H2(i,j) = 1;
        else
            fprintf('Correlation between %s and %s\n',deblank(tittxt(i,:)),deblank(tittxt(j,:)));
            H2(i,j) = 0;
        end
    end
end
%% Check if methods agree
disp([' '])
disp(['********** Check if methods agree from a small sample **********']);
for i=5:p-1
    for j=i+1:p-1
        if (H1(i,j)==H2(i,j))
            fprintf('Methods agree on the hypothesis that r=0 between %s and %s\n',deblank(tittxt(i,:)),deblank(tittxt(j,:)));
        else
            fprintf('Methods do not agree on the hypothesis that r=0 %s and %s\n',deblank(tittxt(i,:)),deblank(tittxt(j,:)));
        end
    end
end
%% Comments
% If two samples are correlated, its printed in the command window.<r(i,j)>
% array hold the Pearson Correlation Coefficient r, where i,j is the samples
% that were tested. <H1> array holds the ttest if r=0. <H2> array holds 
% the bootstrap method if r=0. H=1 indicated that r~=0, and H=0 indicates
% that r=0 at 95% significance level.
% Both methods agree!
% Note that the bootstrap was done for the initial sample of <nn>
% observations. Change <nn> for global results :)