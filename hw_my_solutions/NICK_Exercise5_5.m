%5-5
%% Data
clc; clear all; close all;
data  = importdata('lightair.dat');
X = data(:,1); %air
Y = data(:,2) + 299792.458; %light
alpha = 0.05;
n = 100;
M = 1000;
%% Bootstrap estimation of b
b0_array = NaN*ones(M,1);
b1_array = NaN*ones(M,1);

for i=1:1:M
    rnd = unidrnd(n,n,1);
    X_new = X(rnd);
    Y_new = Y(rnd);

    XX = [ones(n,1) X_new];
    b = XX\Y_new; %b0 = b(1) & b1 = b(2);
    b0_array(i) = b(1);
    b1_array(i) = b(2); 
end

b0_array = sort(b0_array);
b1_array = sort(b1_array);

b0_low = b0_array(floor(M*alpha/2));
b0_upper = b0_array(floor(M*(1-alpha/2)));

b1_low = b1_array(floor(M*alpha/2));
b1_upper = b1_array(floor(M*(1-alpha/2)));

disp(['Bootstrap CI for b0: [',num2str(b0_low),' ',num2str(b0_upper),']'])
disp(['Bootstrap CI for b1: [',num2str(b1_low),' ',num2str(b1_upper),']'])