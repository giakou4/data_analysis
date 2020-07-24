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
n = length(data);
iter = find(area==0); %iter: area not burnt
A = [RH(iter) wind(iter) rain(iter)];
iter2 = find(area~=0); %iter: area burnt
B = [RH(iter2) wind(iter2) rain(iter2)];
clear iter;clear iter2;clear RH;clear wind;clear rain;clear area;clear data;
tittxt = str2mat('relative humidity','wind speed','outside rain');
[~, p] = size(A);
%% Repetitions
BB = 1000; % Bootstrap iterations
M = 50; % no of samples to check for <nn> observations
nn = 20; % no of lower observations to check
replacement = true;
%% Solution: Difference of Meadians (Hypothesis Testing) for all data
medianH = NaN*ones(p,1); %H=0 if medians are equals, 1 of not
for i=1:p
   AB = [A(:,i);B(:,i)];
   medianBoot = NaN*ones(BB,1);
   for j=1:BB
       ABtemp = randsample(AB,length(AB),replacement);
       medianTempA = median(ABtemp(1:length(A)));
       medianTempB = median(ABtemp(length(A)+1:end));
       medianBoot(j) = medianTempA - medianTempB;
   end
   meadianBoot = sort(medianBoot);
   [~,r] = min(abs(medianBoot - median(A(:,i)) + median(B(:,i))));
   if r<(BB+1)*alpha/2 | r>(BB+1)*(1-alpha/2)
       medianH(i) = 1;
   else
       medianH(i) = 0;
   end
   fprintf('Null hypothesis: %s medians are equal resulted H = %.0f\n',deblank(tittxt(i,:)),medianH(i))
end
%% Solution: Difference of Meadians (Hypothesis Testing) for smaller data
medianBootSmall = NaN*ones(M,p);
for i=1:p
    for j=1:M
       idx  = unidrnd(min(length(A),length(B)),nn,1);
       ABsmall = [A(idx,i);B(idx,i)];
       medianBoot = NaN*ones(BB,1);
       for k=1:BB
           ABtemp = randsample(ABsmall,2*nn,replacement);
           medianTempA = median(ABtemp(1:nn));
           medianTempB = median(ABtemp(nn+1:end));
           medianBoot(k) = medianTempA - medianTempB;
       end
       meadianBoot = sort(medianBoot);
       [~,r] = min(abs(medianBoot - median(A(idx,i)) + median(B(idx,i)) ));
       if r<(BB+1)*alpha/2 | r>(BB+1)*(1-alpha/2)
           medianBootSmall(j,i) = 1;
       else
           medianBootSmall(j,i) = 0;
       end
    end
end

for i=1:p % Print histograms
    figure(i)
    clf
    suptitle(sprintf('Hypothesis Testing: Medians are equal\nfor %s\n(from %.0f samples of %.0f observations)',deblank(tittxt(i,:)),M,nn))
    pie([length(find(medianBootSmall(:,i)==1))/M,length(find(medianBootSmall(:,i)==0))/M],{'H=1','H=0'});
end
%% Comments
% Smaller data and all data totally agree!