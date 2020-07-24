%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
% This script tries to fit a function to wind vs temperature
% Group4Exe5Fun1 = Fit Intrinsically  Linear 1
% Group4Exe5Fun2 = Fit Intrinsically  Linear 2
% Group4Exe5Fun3 = Fit Intrinsically  Linear 3
% Group4Exe5Fun4 = Fit Intrinsically  Linear 4
% Group4Exe5Fun5 = Fit Linear degree k
%% Import Data
clc; clear all; close all;
data = importdata('forestfires.dat');
temp = data(:,9); %2.2 - 33.30 temperature[Celcius]
wind = data(:,11); %0.40 - 9.40 wind speed[km/h]
%% Take Smaller Sample x,y
n = 40; %how many observations to keep
idx = unidrnd(length(data),n,1);
y = wind(idx);
x = temp(idx);
K = 9; %max poly degree
warning off
%% Scatter Plot x vs y
figure(1)
scatter(x,y)
title('RH vs temp')
xlabel('temp')
ylabel('wind')
title('Intrinsically Linear fits')
%% [1] y=A*exp(B*x)
[A,B,adjRsq1,e1] = Group4Exe5Fun1(x,y);

figure(1)
hold on
xx = min(x):0.01:max(x);
plot(xx,A*exp(B*xx),'--r')
%% [2] y=A*(x^B)
[A,B,adjRsq2,e2] = Group4Exe5Fun2(x,y);

figure(1)
hold on
plot(xx,A*(xx.^B),'--g')
%% [3] y=A+B*log(x)
[A,B,adjRsq3,e3] = Group4Exe5Fun3(x,y);

figure(1)
hold on
xx = min(x):0.01:max(x);
plot(xx,A+B*log(xx),'--c')
%% [4] y=A+B*(1/x)
[A,B,adjRsq4,e4] = Group4Exe5Fun4(x,y);

figure(1)
hold on
plot(xx,A+B*(1./xx),'--m')

legend('data','y=A*exp(B*x)','y=A*x^B','y=A+B*log(x)','y=A+B*(1/x)')
text(5,3,sprintf('adjR^2=\n %f \n %f \n %f \n %f \n %f',adjRsq1,adjRsq2,adjRsq3,adjRsq4))
%% Diagnostic Plots (Loop Unrolled :P)
figure(2)
suptitle('Diagnostic Plots of Intrinsically Linear Regression')
e1= e1/std(e1);
e2 = e2/std(e2);
e3 = e3/std(e3);
e4 = e4/std(e4);
subplot(2,2,1)
plot(e1,'o')
title('y=A*exp(B*x)')
hold on
plot(1:n,1.96*ones(n),'--r')
hold on
plot(1:n,-1.96*ones(n),'--r')
subplot(2,2,2)
plot(e2,'o')
title('y=A*x^B')
hold on
plot(1:n,1.96*ones(n),'--r')
hold on
plot(1:n,-1.96*ones(n),'--r')
subplot(2,2,3)
plot(e3,'o')
title('y=A+B*log(x)')
hold on
plot(1:n,1.96*ones(n),'--r')
hold on
plot(1:n,-1.96*ones(n),'--r')
subplot(2,2,4)
plot(e4,'o')
title('y=A+B*(1/x)')
hold on
plot(1:n,1.96*ones(n),'--r')
hold on
plot(1:n,-1.96*ones(n),'--r')
%% Polynomial fit
Legend=cell(K+1,1);
Legend{1} = strcat('data');

figure(3)
scatter(x,y)
xlabel('temp')
ylabel('wind')
title('Linear poly fits')

for k=1:K
    [b,yfit,e,adjRsq] = Group4Exe5Fun5(x,y,k);
    
    figure(3)
    hold on 
    plot(xx,polyval(b,xx),'color',rand(1,3),'linestyle','--')
    Legend{k+1}=strcat('degree of poly:', num2str(k));

    figure(4)
    suptitle('Diagnostic plots for linear poly fits')
    subplot(ceil(sqrt(K)),ceil(sqrt(K)),k)
    e_star = e/std(e);
    plot(e_star,'o');
    hold on
    xxx = -1:n+1;
    plot(xxx,1.96*ones(size(xxx)),'--r')
    hold on
    plot(xxx,-1.96*ones(size(xxx)),'--r')
    ylim([min(e_star)-1 max(e_star)+1])
    title(['Diagnostic plot for poly fit degree ',num2str(k)])
    text(1,-3,sprintf('adjR^2 = %f',adjRsq));
end
figure(3)
legend('data',Legend);
    
%% Comments 
% No good models here because adjR2 is low. However R2 can be good
% sometimes but its because of overfitting (mostly for higher poly degrees.