%% 5-6
%% Data
clc; close all; clear all;
X = [2 3 8 16 32 48 64 80]'; %distance 100*km
Y = [98.2 91.7 81.3 64.0 36.4 32.6 17.1 11.3]'; %usability rate
n = length(X);
%% Scatter plot
figure(1)
scatter(X,Y)
xlabel('distance [100*km]');
ylabel('usability rate');
r = corr(X,Y);

%% Apply Linear Regression Model
XX = [ones(n,1) X];
for i=1:4 %max poly degree = 4 default
    b = polyfit(X,Y,i);
    yfit = polyval(b,X);
    e = Y - yfit;
    e_star = e/std(e);
    SSresid = sum(e.^2);
    SStotal = (n-1)*var(Y);
    Rsq = 1 - SSresid/SStotal;
    adjRsq = 1 - SSresid/SStotal * (n-1)/(n-i-1);
    figure(1)
    hold on
    plot(X,yfit,'color',rand(1,3));
    
    figure(2)
    suptitle('Scatter plot')
    subplot(2,2,i)
    plot(e_star,'o');
    hold on
    xx = -1:n+1;
    plot(xx,1.96*ones(size(xx)),'--r')
    hold on
    plot(xx,-1.96*ones(size(xx)),'--r')
    ylim([min(e_star)+-1 max(e_star)+1])
    title(['Scatter plot for poly fit degree ',num2str(i)])
    text(1,-1,sprintf('R^2 = %f\nadjR^2 = %f',Rsq,adjRsq));
end

%% Apply Non-Linear Regression Model - Intrinsically Linear Y=a*exp(b*X)
Yln = log(Y);
b = XX\Yln;
yfitln = exp(b(1))*exp(b(2)*X);
yfit = XX*b;
e = Yln - yfit;
e_star = e/std(e);

figure(1)
hold on
plot(X,yfitln)
legend('data','poly d=1','poly d=2','poly d=3','poly d=4',sprintf('y=%.3f*exp(%.3f*x)',exp(b(1)),b(2)));

figure(3)
plot(e_star,'o');
hold on
xx = -1:n+1;
plot(xx,1.96*ones(size(xx)),'--r')
hold on
plot(xx,-1.96*ones(size(xx)),'--r')   
ylim([min(e_star)+-1 max(e_star)+1])
title(['Scatter plot for intrinsically linear regression model'])
SSresid = sum(e.^2);
SStotal = (n-1)*var(Yln);
Rsq = 1 - SSresid/SStotal;
adjRsq = 1 - SSresid/SStotal * (n-1)/(n-1-1);
text(1,-1,sprintf('R^2 = %f\nadjR^2 = %f',Rsq,adjRsq));