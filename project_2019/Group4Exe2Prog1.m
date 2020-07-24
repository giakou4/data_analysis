%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
%% Data
clc; clear all; close all;
data = importdata('forestfires.dat');
RH = data(:,10); %15.0 - 100 relative humidity[%]
wind = data(:,11); %0.40 - 9.40 wind speed[km/h]
rain = data(:,12); %0.0 - 6.4 outside rain[mm/m2]
area = data(:,13); %0.00 - 1090.84 burned area[ha]
alpha = 0.05;
iter = find(area==0); %iter: area not burnt
A = [RH(iter) wind(iter) rain(iter)];
iter2 = find(area~=0); %iter: area burnt
B = [RH(iter2) wind(iter2) rain(iter2)];
clear iter;clear iter2;clear area;clear wind; clear rain; clear RH;clear data;
tittxt = str2mat('relative humidity','wind speed','outside rain');
[~, p] = size(A);
%% Repetitions
M = 50;
nn = 20;
bins = floor(sqrt(M));
%% Difference of means - CI for all data
CI_ALL = NaN*ones(2*p,1); %position i holds left CI, position i+p hols upper CI
for i=1:p
    [~,~,CI] = ttest2(A(:,i),B(:,i),alpha);
    CI_ALL(i) = CI(1);
    CI_ALL(i+p) = CI(2);
    disp(deblank(tittxt(i,:)));
    fprintf('%.2f%% CI for difference of means is: [%f %f]\n\n',100*(1-alpha),CI(1),CI(2))
end
%% DIfference of means - CI for smaller data
AA = NaN*ones(nn,p); %holds smaller sample of A
BB = NaN*ones(nn,p); %holds smaller sample of B

CI_SMALL = NaN*ones(M,2*p); %position i holds left CI, position i+p hols upper CI

for i=1:M
    for j=1:p % Create my random sample with no replacement of my data
    AA(:,j) = randsample(A(:,j),nn,'false');
    BB(:,j) = randsample(B(:,j),nn,'false');
    end
    
    for j=1:p % Calculater the CI
        [~,~,CI] = ttest2(AA(:,j),BB(:,j),alpha);
        CI_SMALL(i,j) = CI(1);
        CI_SMALL(i,j+p) = CI(2);
    end
end
clear AA;clear BB;
for i=1:p % Print histograms
    figure(i)
    clf
    suptitle(sprintf('Confident Interval Histogram for %s',deblank(tittxt(i,:))))
    subplot(1,2,1)
    [counts, centers] = hist(CI_SMALL(:,i));
    bar(centers,counts)
    hold on
    plot([CI_ALL(i) CI_ALL(i)],[0 1.1*max(counts)],'r','LineWidth',3)
    legend(sprintf('Low value for %.0f observations',nn),'Low value for all obervations')
    title('Lower Value of CI')
    subplot(1,2,2)
    [counts, centers] = hist(CI_SMALL(:,i+p));
    bar(centers,counts)
    hold on
    plot([CI_ALL(i+p) CI_ALL(i+p)],[0 1.1*max(counts)],'r','LineWidth',3)
    legend(sprintf('Upper value for %.0f observations',nn),'Upper value for all obervations')
    title('Upper Value of CI')
end
clear centers; clear counts;
%% Check if methods agree
% Method: If value(lower or upper value of CI) inside (1-alpha)% of  
% distribution concludes to acceptance. 
for i=1:p
    CI_SMALL(:,i) = sort(CI_SMALL(:,i));
    [~,pos] = min(abs(CI_SMALL(:,i)-CI_ALL(i)));
    if pos<(M+1)*alpha/2 | pos>(M+1)*(1-alpha/2)
        fprintf('Cannot accept lower value of CI for %s\n',deblank(tittxt(i,:)))
    else
        fprintf('Can accept lower value of CI for %s\n',deblank(tittxt(i,:)))
    end
    
    CI_SMALL(:,i+p) = sort(CI_SMALL(:,i+p));
    [~,pos] = min(abs(CI_SMALL(:,i+p)-CI_ALL(i+p)));
    if pos<(M+1)*alpha/2 | pos>(M+1)*(1-alpha/2)
        fprintf('Cannot accept upper value of CI for %s\n',deblank(tittxt(i,:)))
    else
        fprintf('Can accept upper value of CI for %s\n',deblank(tittxt(i,:)))
    end
end  
%% Comments
% For M sampels of nn=20 observations, the CI of RH and wind are much more 
% greater meaning we do not find the CI of all data with more significance.
% The CI always agree.