%% 5-6
%% Data
clc; close all; clear all;
R = [0.76 0.86 0.97 1.11 1.45 1.67 1.92 2.23 2.59 3.02 3.54 4.16 4.91 ...
     5.83 6.94 8.31 10.00 12.09 14.68 17.96 22.05 27.28 33.89 42.45 ...
     53.39 67.74 86.39 111.30 144.00 188.40 247.50 329.20]';
T_celcius = [110 105 100 95 85 80 75 70 65 60 55 50 45 40 35 30 25 20 ...
    15 10 5 0 -5 -10 -15 -20 -25 -30 -35 -40 -45 -50]';
T = T_celcius + 273.15;
max_poly_degree = 4;
n = length(R);
%% Transform Data
X = log(R);
Y = 1./T;
figure(1)
scatter(X,Y)
xlabel('log(R)')
ylabel('1/T')
%% Apply Linear Regression Model
Legend=cell(max_poly_degree,1);
XX = [ones(n,1) X];
for i=1:max_poly_degree
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
    Legend{i}=strcat('degree of poly:', num2str(i));
    
    figure(2)
    suptitle('Scatter plots')
    subplot(ceil(sqrt(max_poly_degree)),ceil(sqrt(max_poly_degree)),i)
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

figure(1)
legend('data',Legend);

%% Steinhart-Hart model

XX = [ones(n,1) X X.^3];
b_steinhart_hart = XX\Y;

figure(3)
subplot(1,2,1)
scatter(X,Y)
title('Scatter Plot')
xlabel('ln(R)')
ylabel('1/T')
hold on
plot(X,b_steinhart_hart(1)+b_steinhart_hart(2)*X+b_steinhart_hart(3)*X.^3,'r')
legend('Data','Steinhart-Hart fit: y = b0 + b1*x + b3*x^3')

subplot(1,2,2)
e_steinhart_hart = Y - (b_steinhart_hart(1)+b_steinhart_hart(2)*X+b_steinhart_hart(3)*X.^3);
se_steinhart_hart = std(e_steinhart_hart);
e_star_steinhart_hart = e_steinhart_hart/se_steinhart_hart;
plot(e_star_steinhart_hart,'o') 
hold on
xx = -1:n+2;
plot(xx,1.96*ones(size(xx)),'--r')
hold on
plot(xx,-1.96*ones(size(xx)),'--r')
title('Diagnostic plot of Steinhart-Hart fit')
legend('e_i/s_e','+1.96','-1.96')
grid on

yresid_steinhart_hart = e_steinhart_hart;
SSresid_steinhart_hart = sum(yresid_steinhart_hart.^2);
SStotal_steinhart_hart = (n-1) * var(Y);
rsq_steinhart_hart = 1 - SSresid/SStotal;
rsq_adj_steinhart_hart = 1 - SSresid/SStotal * (n-1)/(n-3-1);
text(1,-1,sprintf('R^2 = %3.7f\nadjR^2 = %3.7f\n',rsq_steinhart_hart,rsq_adj_steinhart_hart))