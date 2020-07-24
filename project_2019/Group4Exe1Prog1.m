%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
clc; clear all; close all;
data = importdata('forestfires.dat');
RH = data(:,10); %15.0 - 100 relative humidity[%]
wind = data(:,11); %0.40 - 9.40 wind speed[km/h]
rain = data(:,12); %0.0 - 6.4 outside rain[mm/m2]
area = data(:,13); %0.00 - 1090.84 burned area[ha]
%% Data
alpha = 0.15;
iter = find(area==0); %iter: area not burnt
A = [RH(iter) wind(iter) rain(iter)];
iter2 = find(area~=0); %iter: area burnt
B = [RH(iter2) wind(iter2) rain(iter2)];
tittxt = str2mat('relative humidity','wind speed','outside rain');
warning off
%% Solution
for i = 1:3
    
    figure(i)
    clf
    suptitle(deblank(tittxt(i,:)))
    subplot(1,2,1)
    hist(A(:,i),floor(sqrt(length(A))));
    title('area not burnt')
    subplot(1,2,2)
    hist(B(:,i),floor(sqrt(length(B))));
    title('area burnt')

    figure(10+i)
    suptitle(deblank(tittxt(i,:)))
    subplot(1,2,1)
    boxplot(A(:,i));
    title('area not burnt')
    subplot(1,2,2)
    boxplot(B(:,i));
    title('area burnt')

    
    [H1,P1,STATS1] = chi2gof(A(:,i),'cdf',@(z)normcdf(z,mean(A(:,i)),sqrt(var(A(:,i)))),'nparams',2,'alpha',alpha);
    [H2,P2,STATS2] = chi2gof(A(:,i),'cdf',@(z)poisscdf(z,mean(A(:,i))),'nparams',1,'alpha',alpha);
    display(['**********************************************************'])
    disp(['AREA NOT BURNT: ',deblank(tittxt(i,:))]);
    display(['**********************************************************'])
    fprintf('Mean = %f\tstd = %f\n',mean(A(:,i)),sqrt(var(A(:,i))))
    fprintf('Goodness-of-fit-test: Normal Distribution H=%.0f p-value=%f\n',H1,P1);
    fprintf('\t observed \t expected frequencies \n');
    for j=1:length(STATS1.O)
        fprintf('\t %3.3f \t %3.3f \n',STATS1.O(j),STATS1.E(j));
    end
    fprintf('Goodness-of-fit-test: Poisson Distribution H=%.0f p-value=%f\n\n',H2,P2);
    fprintf('\t observed \t expected frequencies \n');
    for j=1:length(STATS2.O)
        fprintf('\t %3.3f \t %3.3f \n',STATS2.O(j),STATS2.E(j));
    end
    
    [H3,P3,STATS3] = chi2gof(B(:,i),'cdf',@(z)normcdf(z,mean(B(:,i)),sqrt(var(B(:,i)))),'nparams',2,'alpha',alpha);
    [H4,P4,STATS4] = chi2gof(B(:,i),'cdf',@(z)poisscdf(z,mean(B(:,i))),'nparams',1,'alpha',alpha);
    display(['**********************************************************'])
    disp(['AREA BURNT: ',deblank(tittxt(i,:))]);
    display(['**********************************************************'])
    fprintf('Mean = %f\tstd = %f\n',mean(B(:,i)),sqrt(var((B(:,i)))));
    fprintf('Goodness-of-fit-test: Normal Distribution H=%.0f p-value=%f\n',H3,P3);
    fprintf('\t observed \t expected frequencies \n');
    for j=1:length(STATS3.O)
        fprintf('\t %3.3f \t %3.3f \n',STATS3.O(j),STATS3.E(j));
    end
    fprintf('Goodness-of-fit-test: Poisson Distribution H=%.0f p-value=%f\n\n',H4,P4)
    fprintf('\t observed \t expected frequencies \n');
    for j=1:length(STATS4.O)
        fprintf('\t %3.3f \t %3.3f \n',STATS4.O(j),STATS4.E(j));
    end
end
%% Comments
% We observe that relative humidity fails to follow poisson or normal
% distribution, so as wind speed. From the other hand, outside rains can
% fit in both normal and poisson distributions. However, the data visually
% seem to fit X^2 and not normal, since the tails are not symmetrical.