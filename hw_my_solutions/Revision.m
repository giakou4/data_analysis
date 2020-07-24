clc; close all; clear all;
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% CHAPTER 3 %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Data
a = 0.05;
n = 100;
mean_matrix = [0 0];
covariance_matrix = [1 0.8;0.8 1];
data = mvnrnd(mean_matrix,covariance_matrix,n);
x = data(:,1);
y = data(:,2);

%% [3.1] Mean, Variance, Histogram
figure(1)
bins = round(sqrt(n));
hist(x,bins)
title('Histogram of X');

meanx = mean(x);
display(['Parametric Mean equals ',num2str(meanx)]);

varx = var(x);
display(['Parametric Variance equals ',num2str(varx)]);

%% [3.2-3.3] Confident Intervals, Hypothesis Testing and Goodness-of-fit test
[H,P,CI] = ttest(x,0,a);
display(['Null hypothesis mean equals 0 ---> H=',num2str(H),' p-value=',num2str(P),' Parametric Mean CI=[',num2str(CI(1)),' ',num2str(CI(2)),']'])

[H,P,CI] = vartest(x,0,a);
display(['Null hypothesis variance equals 0 ---> H=',num2str(H),' p-value=',num2str(P),' Parametric Variance CI=[',num2str(CI(1)),' ',num2str(CI(2)),']'])

[H,P] = chi2gof(x,'cdf',@(z)normcdf(z,mean(x),std(x)),'nparams',2);
display(['Null hypothesis: data come from normal distribution ---> H=',num2str(H),' p-value=',num2str(P)])

%% [3.4] Bootstrap CI for Mean and Variance
B = 100;

CI = bootci(B,{@mean,x},'alpha',a);
display(['Bootstrap Mean CI=[',num2str(CI(1)),' ',num2str(CI(2)),']'])

CI = bootci(B,{@var,x},'alpha',a);
display(['Bootstrap Variance CI=[',num2str(CI(1)),' ',num2str(CI(2)),']'])

%% [3.4] Methods to check if mean(x)=mean(y)
%% (A) Parametric (1-a)% CI

[~,~,CI] = ttest2(x,y,a);
display(['Parametric (1-a)% CI=[',num2str(CI(1)),' ',num2str(CI(2)),']'])

%% (B) Bootstrap (1-a)% CI

B = 100;
bootstatx = bootstrp(B,@mean,x);
bootstaty = bootstrp(B,@mean,y);
bootstatxy = bootstatx-bootstaty;
bootstatxy = sort(bootstatxy);
k = floor((B+1)*a/2);
CI = [bootstatxy(k) bootstatxy(B+1-k)];
display(['Bootstrap (1-a)% CI=[',num2str(CI(1)),' ',num2str(CI(2)),']'])

%% (C) Parametric Hypothesis testing

[H,P,~] = ttest(x,y,a);
display(['Null hypothesis means are equals ---> H=',num2str(H),' p-value=',num2str(P)]);

%% (D) Bootstrap Hypothesis Testing

replacement = true;
xy = [x;y];
xy_bootstrap = NaN*ones(1,B);
for k=1:B
    bootstrap_samples = randsample(xy,n+n,replacement);
    meanx = mean(bootstrap_samples(1:n));
    meany = mean(bootstrap_samples(n+1:end));
    xy_bootstrap(k) = (meanx-meany);
end
xy_bootstrap = sort(xy_bootstrap);
[~,r] = min(abs((xy_bootstrap-(mean(x)-mean(y)))));
if r<(B+1)*a/2 | r>(B+1)*(1-a/2) 
    H = 1;
else
    H = 0;
end
display(['Bootstrap Hypothesis Testing: Null hypothesis: mean are equals ---> H=',num2str(H)])

%% (E) Randomization

replacement = false;
xy = [x;y];
xy_bootstrap = NaN*ones(1,B);
for k=1:B
    bootstrap_samples = randsample(xy,n+n,replacement);
    meanx = mean(bootstrap_samples(1:n));
    meany = mean(bootstrap_samples(n+1:end));
    xy_bootstrap(k) = (meanx-meany);
end
xy_bootstrap = sort(xy_bootstrap);
[~,r] = min(abs((xy_bootstrap-(mean(x)-mean(y)))));
if r<(B+1)*a/2 | r>(B+1)*(1-a/2) 
    H = 1;
else
    H = 0;
end
display(['Randomization Hypothesis Testing: Null hypothesis: mean are equals ---> H=',num2str(H)])

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% CHAPTER 5 %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% [5.1] Scatter Plot 

figure(2)
scatter(x,y)
title('Scatter Plot')

%% [5.1] Calculate r, CI of r, hypothesis testing for r

temp = corrcoef(x,y);
r = temp(1,2);
display(['r=',num2str(r)])

z = 0.5*log((1+r)/(1-r));
CI = [z-norminv(1-a/2)*sqrt(1/(n-3)) z+norminv(1-a/2)*sqrt(1/(n-3))];
CI = [tanh(CI(1)) tanh(CI(2))];
display(['Fisher Transformation z=tanh{^-1}(r) (1-a)% CI=[',num2str(CI(1)),' ',num2str(CI(2)),']'])

t0 = r*sqrt((n-2)/(1-r^2));
if t0<-tinv(1-a/2,n-2) | t0>tinv(1-a/2,n-2)
    H = 1;
else
    H = 0;
end
display(['Hypothesis Testing: Null hypothesis r=0 ---> H=',num2str(H)])

%% [5.2] Linear Regression

X = [ones(n,1) x];
b = X\y;
yfit = X*b;
e = y - yfit;
se = std(e);
SSresid = sum(e.^2);
SStotal = (length(y)-1)*var(y);
rsq = 1 - SSresid/SStotal;
rsq_adj = 1 - SSresid/SStotal*((n-1)/(n-1-1));

% Calclulate CI of b
b0 = b(1);
b1 = b(2);
sxx = (n-1)*var(x);
sb0 = se*sqrt(1/n + mean(x)^2/sxx);
b0_left = b0 - tinv(1-a/2,n-2)*sb0;
b0_right = b0 + tinv(1-a/2,n-2)*sb0;
display(['b0 confident interval: [',num2str(b0_left),' ',num2str(b0_right),']'])

sb1 = se/sqrt(sxx);
b1_left = b1 - tinv(1-a/2,n-2)*sb1;
b1_right = b1 + tinv(1-a/2,n-2)*sb1;
display(['b1 confident interval: [',num2str(b1_left),' ',num2str(b1_right),']'])

% Scatter plot, linear regression model, future and mean prediction
figure(3)
scatter(x,y);
hold on
plot(x,X*b,'--r');
hold on
xx = min(x):0.01:max(x);
plot(xx,(b0+b1*xx)-tinv(1-a/2,n-2)*se*sqrt(1/n+((xx-meanx).^2)/sxx),'-g')
hold on
plot(xx,(b0+b1*xx)+tinv(1-a/2,n-2)*se*sqrt(1/n+((xx-meanx).^2)/sxx),'-g')
hold on
plot(xx,(b0+b1*xx)-tinv(1-a/2,n-2)*se*sqrt(1+1/n+((xx-meanx).^2)/sxx),'-m')
hold on
plot(xx,(b0+b1*xx)+tinv(1-a/2,n-2)*se*sqrt(1+1/n+((xx-meanx).^2)/sxx),'-m')
legend('Data','Slope & Intercept','Mean Prediction Low','Mean Prediction Upper','Future Prediction Low','Future Prediction Upper');
title('Linear Regression')
text(min(x),max(y),['R^2=',num2str(rsq),' adjR^2=',num2str(rsq_adj)]);

%Diagnostic Plot
figure(4)
e_star = e/se;
plot(e_star,'o');
xx = -1:0.1:n+2;
hold on
plot(xx,1.96*ones(size(xx)),'--r')
hold on
plot(xx,-1.96*ones(size(xx)),'--r')
title('Diagnostic Plot')

%% [5.3] Non-Linear Regression]
%% [5.3.1] Intrinsically LInear

lny = log(y); % apply y=a*e^(b*x)
X = [ones(n,1) x];
b = X\lny; %y'=ln(y) => y = ln(a) + b*x
yfit = X*b;
e = lny-yfit;

figure(5)
clf
scatter(x,y);
hold on
xx = min(x):0.01:max(x);
plot(xx,exp(b(1))*exp(b(2)*xx),'--r')
title('Intriniscally Linear Regression')
legend('Data','y=a*exp(b*x)');

%% [5.3.2] Polynomial Regression

k=5; %poly degree
b = polyfit(x,y,k);
yfit = polyval(b,x);
e = y-yfit;
SSresid = sum(e.^2);
SStotal = (length(y)-1)*var(y);
rsq = 1 - SSresid/SStotal;
rsq_adj = 1 - SSresid/SStotal*((n-1)/(n-k-1));

figure(6)
clf
scatter(x,y);
hold on
xx = min(x):0.01:max(x);
plot(xx,polyval(b,xx),'r')
title('Intriniscally Linear Regression')
legend('Data','Intriniscally Linear Model')
text(min(x),max(y),['R^2=',num2str(rsq),' adjR^2=',num2str(rsq_adj)]);

%% [5.4] Linear Multiple Regression Model





