% 2-4
% Generation of uniform data and computation of the 1/E[x] and E[1/x]
%% Data

clc; clear all; close all;
n = 2.^(1:15);
a = 0;
b = 1;

%% Solution

mean1 = NaN*zeros(1,length(n)); % Hold E[1/X]
mean2 = NaN*zeros(1,length(n)); % Hold 1/E[X]

for i=1:length(n)
    X = unifrnd(a,b,n(i),1);
    mean1(1,i) = mean(1./X);
    mean2(1,i) = 1/mean(X);
    fprintf('n  = %3.0f\nE[1/X] = %3.7f\n1/E[X] = %3.7f\n',n(i),mean1(1,i),mean2(1,i));
end

figure(1)
i = 1:length(n);
plot(i,mean1(1,:),'b--o');
hold on 
plot(i,mean2(1,:),'r--o');
hold on
plot(i,(1/(b-a))*ones(size(i)),'g');
legend('E[1/X]','1/E[X]','True 1/E[X]')
xlabel('2^n')
ylabel('value')