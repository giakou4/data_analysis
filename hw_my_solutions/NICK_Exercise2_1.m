% 2-1
%% Coin simulator 
clc; clear all; close all;

n = 2.^(2:17)';

heads = NaN*ones(1,length(n));
tails = NaN*ones(1,length(n));

for i=1:length(n)
    X = unifrnd(0,1,n(i),1);
    heads(1,i) = length(find(X<0.5))/n(i);
    tails(1,i) = (1-heads(1,i));

end

figure(1)
clf
i=1:length(n);
plot(i,heads,'c');
hold on
plot(i,tails,'r');
title('Coin Simulator')
xlabel('2^n');
ylabel('Probability');
legend('heads','tails')