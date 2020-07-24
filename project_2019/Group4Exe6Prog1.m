%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
%% Data
clc; clear all; close all;
data = importdata('forestfires.dat');
temp = data(:,9); %2.2 - 33.30 temperature[Celcius]
RH = data(:,10); %15.0 - 100 relative humidity[%]
n = length(temp);
clear data; clear idx;
alpha = 0.05;
M = 100;
nn = 40;
B = 1000;
%% 'Real' b, estimated with OLS from all observations
b = [ones(n,1) RH]\temp; 
fprintf('Initial sample: y = b0 + b1*x where b0=%f and b1=%f\n',b(1),b(2));

%% Estimate b
b_est = NaN*ones(M,2); %holds b0 and b1
b0_par_ci = NaN*ones(M,2); %holds b0 parametric CI
b1_par_ci = NaN*ones(M,2); %holds b1 parametric CI
b0_boot_ci = NaN*ones(M,2); %holds b0 bootstrap CI
b1_boot_ci = NaN*ones(M,2); %holds b1 bootstrap CI
%% How to estimate them:
for i=1:M
    if (i/2)==floor(i/2)
        fprintf('.')
    end
    idx = unidrnd(n,nn,1);
    x = RH(idx);
    y = temp(idx);
    %find b
    b_est(i,1:2) = [ones(nn,1) x]\y;
    yfit = [ones(nn,1) x]*b_est(i,1:2)';
    e = y - yfit;
    sxx = (nn-1)*var(x);
    %find parametric CI of b
    b0_par_ci(i,1) = b_est(i,1)-tinv(1-alpha/2,nn-2)*std(e)*sqrt(1/nn+mean(x)^2/sxx);
    b0_par_ci(i,2) = b_est(i,1)+tinv(1-alpha/2,nn-2)*std(e)*sqrt(1/nn+mean(x)^2/sxx);
    b1_par_ci(i,1) = b_est(i,2)-tinv(1-alpha/2,nn-2)*std(e)/sqrt(sxx);
    b1_par_ci(i,2) = b_est(i,2)+tinv(1-alpha/2,nn-2)*std(e)/sqrt(sxx);
    %find bootstrap CI of b
    b0_bb = NaN*ones(B,1);
    b1_bb = NaN*ones(B,1);
    for k=1:B
        idx = unidrnd(nn,nn,1);
        xboot = x(idx);
        yboot = y(idx);
        bboot = [ones(nn,1) xboot]\yboot;
        b0_bb(k) = bboot(1);
        b1_bb(k) = bboot(2);
        clear bboot;
    end
    K = floor((B+1)*alpha/2);
    b0_bb = sort(b0_bb);
    b1_bb = sort(b1_bb);
    b0_boot_ci(i,1) = b0_bb(K);
    b0_boot_ci(i,2) = b0_bb(B+1-K);
    b1_boot_ci(i,1) = b1_bb(K);
    b1_boot_ci(i,2) = b1_bb(B+1-K);   
end
fprintf('\n')
%% Methods' Precision
b0_par_H = 0;
b1_par_H = 0;
b0_boot_H = 0;
b1_boot_H = 0;
for i=1:M
    if b(1)>b0_par_ci(i,1) && b(1)<b0_par_ci(i,2)
        b0_par_H = b0_par_H + 1;
    end
    
    if b(2)>b1_par_ci(i,1) && b(2)<b1_par_ci(i,2)
        b1_par_H = b1_par_H + 1;
    end
    
    if b(1)>b0_boot_ci(i,1) && b(1)<b0_boot_ci(i,2)
        b0_boot_H = b0_boot_H + 1;
    end
    
    if b(2)>b1_boot_ci(i,1) && b(2)<b1_boot_ci(i,2)
        b1_boot_H = b1_boot_H + 1;
    end
end
b0_par_H = b0_par_H/M;
b1_par_H = b1_par_H/M;
b0_boot_H = b0_boot_H/M;
b1_boot_H = b1_boot_H/M;
fprintf('Real b0 inside parametric CI: %2.2f%% and inside bootstrap CI: %2.2f%%\n',100*b0_par_H,100*b0_boot_H);
fprintf('Real b1 inside parametric CI: %2.2f%% and inside bootstrap CI: %2.2f%%\n',100*b1_par_H,100*b1_boot_H);
%% Print Histograms
figure(1)
clf
suptitle(sprintf('b0 Confidence Interval (real b0=%f)',b(1)))
subplot(2,2,1)
hist(b0_par_ci(:,1)) %b0 Parametric Low
title('Parametric Low')
subplot(2,2,3)
hist(b0_boot_ci(:,1)) %b0 Bootstrap Low
title('Bootstrap Low')
subplot(2,2,2)
hist(b0_par_ci(:,2)) %b0 Parametric Upper
title('Parametric Upper')
subplot(2,2,4)
hist(b0_boot_ci(:,2)) %b0 Bootstrap Upper
title('Bootstrap Upper')

figure(2)
clf
suptitle(sprintf('b1 Confidence Interval (real b0=%f)',b(2)))
subplot(2,2,1)
hist(b1_par_ci(:,1)) %b1 Parametric Low
title('Parametric Low')
subplot(2,2,3)
hist(b1_boot_ci(:,1)) %b1 Bootstrap Low
title('Bootstrap Low')
subplot(2,2,2)
hist(b1_par_ci(:,2)) %b1 Parametric Upper
title('Parametric Upper')
subplot(2,2,4)
hist(b1_boot_ci(:,2)) %b1 Bootstrap Upper
title('Bootstrap Upper')
%% Comments
% Real b1 and b0 and inside at both parametric and bootstrap CI most of the
% times >90%