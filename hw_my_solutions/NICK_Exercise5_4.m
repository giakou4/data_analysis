% 5-4
%% Data
clc; clear all; close all;
data  = importdata('lightair.dat');
x = data(:,1); %air
y = data(:,2); %light
alpha = 0.05;
n = 100;
c = 299792.458;
d0 = 1.29;
y = y+c;
%% [a] Scatter plot & r estmation
disp(['[a]'])

r = corr(x,y);
display(['Correlation(x,y) = r = ',num2str(r)])

figure(1)
scatter(x,y)
title('Scatter Plot')
xlabel('air')
ylabel('light')

disp(['Check figure'])
%% [b] Linear Regression: estimate b
disp(['[b]'])

X = [ones(length(x),1) x];
b = X\y;
yfit = X*b;
e = y - yfit;
se = std(e);
sxx = (n-1)*var(x);

hold on 
plot(x,yfit,'r')
legend('Data','y = b_0 + b_1*x','Location','best');

b0 = b(1);
b1 = b(2);
display(['Slope b0=',num2str(b0),' & Intercepton b1=',num2str(b1)])

%% CI of b
sb0 = se*sqrt(1/n + mean(x)^2/sxx);
b0_left = b0 - tinv(1-alpha/2,n-2)*sb0;
b0_right = b0 + tinv(1-alpha/2,n-2)*sb0;
display(['b0 confident interval: [',num2str(b0_left),' ',num2str(b0_right),']'])
sb1 = se/sqrt(sxx);
b1_left = b1 - tinv(1-alpha/2,n-2)*sb1;
b1_right = b1 + tinv(1-alpha/2,n-2)*sb1;
display(['b1 confident interval: [',num2str(b1_left),' ',num2str(b1_right),']'])
%% [c] Mean and Future prediction
disp(['[c]'])

figure(2)
scatter(x,y)
title('Scatter Plot')
xlabel('air')
ylabel('light')
hold on 
plot(x,X*b,'r')
hold on
meanx = mean(x);
Xstep = min(x):0.01:max(x);
plot(Xstep,(b0+b1*Xstep)-tinv(1-alpha/2,n-2)*se*sqrt(1/n+((Xstep-meanx).^2)/sxx),'-g')
hold on
plot(Xstep,(b0+b1*Xstep)+tinv(1-alpha/2,n-2)*se*sqrt(1/n+((Xstep-meanx).^2)/sxx),'-g')
hold on
plot(Xstep,(b0+b1*Xstep)-tinv(1-alpha/2,n-2)*se*sqrt(1+1/n+((Xstep-meanx).^2)/sxx),'-m')
hold on
plot(Xstep,(b0+b1*Xstep)+tinv(1-alpha/2,n-2)*se*sqrt(1+1/n+((Xstep-meanx).^2)/sxx),'-m')
legend('Data','y = b_0 + b_1*x','Mean Prediction Low','Mean Prediction Upper','Future Prediction Low','Future Prediction Upper','Location','best');

%% Prediction for test value x=d0=1.29 kg/m^3
y_est1 = b0 + b1*d0;
sy_est = se*sqrt(1/n + (d0-mean(x))/sxx);
mean_prediction_low1 = y_est1 - tinv(1-alpha/2,n-2)*sy_est;
mean_prediction_upper1 = y_est1 + tinv(1-alpha/2,n-2)*sy_est;
future_prediction_low1 = y_est1 - tinv(1-alpha/2,n-2)*sqrt(se^2+sy_est^2);
future_prediction_upper1 = y_est1 + tinv(1-alpha/2,n-2)*sqrt(se^2+sy_est^2);
disp(['Test value x=1.29 kg/m^3'])
disp(['Mean Prediction: [',num2str(mean_prediction_low1),' ',num2str(mean_prediction_upper1),']'])
disp(['Future Prediction: [',num2str(future_prediction_low1),' ',num2str(future_prediction_upper1),']'])
%% [d] Real one
disp(['[d]'])

y_real = c*(1-0.00029*x/d0);
b_real = X\y_real;
b0_real = b_real(1);
b1_real = b_real(2);
display(['Real Slope b0=',num2str(b0_real),' & Real Intercepton b1=',num2str(b1_real)])

t1 = (b1-b1_real)/sb1;
t0 = (b0-b0_real)/sb0;

if( t1<-tinv(1-alpha/2,n-2) | t1>tinv(1-alpha/2,n-2)  )%out of borders
        display(['b1=',num2str(b0),' cannot be b1_real=',num2str(b0_real)])
else
    display(['b1 = ',num2str(b0),' can be b1_real = ',num2str(b0_real)])
end

if( t0<-tinv(1-alpha/2,n-2) | t0>tinv(1-alpha/2,n-2)  )%out of borders
        display(['b0=',num2str(b0),' cannot be b0_real=',num2str(b0_real)])
else
    display(['b0 = ',num2str(b0),' can be b0_real = ',num2str(b0_real)])
end