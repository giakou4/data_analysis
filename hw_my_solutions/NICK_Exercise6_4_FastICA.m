% Exercise 6.4

%% Original Data
clc; clear all; close all;
s1 = importdata('chirp.mat');
s1 = s1.y;
s1 = s1(1:10000,1);

s2 = importdata('gong.mat');
s2 = s2.y;
s2 = s2(1:10000,1);

S = [s1 s2];
clear s1; clear s2;

figure(1) % Plot S
subplot(2,2,1)
plot(S(:,1))
title('Source Signal 1: Chirp')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(S(:,2))
ylabel('s2(t)')
xlabel('t')
title('Source Signal 2: Gong')
subplot(2,2,3)
scatter(S(:,1),S(:,2),'.')
title('Scatter diagram 2-D')

%% (a) Transform in R^2

A2 = [-0.1 0.3;
    -2.5 -0.2];

X2 = S*A2; % Mix signals R^2

figure(2) % Plot mixed signals in R^2
subplot(2,2,1)
plot(X2(:,1))
title('Mixed Signal 1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(X2(:,2))
ylabel('s2(t)')
xlabel('t')
title('Mixed Signal 2')
subplot(2,2,3)
scatter(X2(:,1),X2(:,2),'.')
title('Scatter diagram 2-D')

%% (a1) ICA Without SVD

[ICA2, A2, W2] = fastica(X2');

figure(3)
subplot(2,2,1)
plot(ICA2(1,:))
title('ICA reconstructed s1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(ICA2(2,:))
title('ICA reconstructed s2')
ylabel('s2(t)')
xlabel('t')
%% (b) Transform in R^2 

A3 = [-0.1 0.3 -0.2;
    -2.5 -0.2 -0.3];

X3 = S*A3; % Mix signals R^3

figure(4) % Plot mixed signals in R^3
subplot(2,2,1)
plot(X3(:,1))
title('Mixed Signal 1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(X3(:,2))
ylabel('s2(t)')
xlabel('t')
title('Mixed Signal 2')
subplot(2,2,3)
plot(X3(:,3))
ylabel('s3(t)')
xlabel('t')
title('Mixed Signal 3')
subplot(2,2,4)
scatter3(X3(:,1),X3(:,2),X3(:,3),'.')
title('Scatter diagram 3-D')

%% (b1) ICA Without SVD

[ICA3, A3, W3] = fastica(X3');

figure(5)
subplot(2,2,1)
plot(ICA3(1,:))
title('ICA reconstructed s1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(ICA3(2,:))
title('ICA reconstructed s2')
ylabel('s2(t)')
xlabel('t')