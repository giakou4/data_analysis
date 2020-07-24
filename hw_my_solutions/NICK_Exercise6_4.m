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

A = [-0.1 0.3;
    -2.5 -0.2];

X = S*A; % Mix signals R^2

figure(2) % Plot mixed signals in R^2
subplot(2,2,1)
plot(X(:,1))
title('Mixed Signal 1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(X(:,2))
ylabel('s2(t)')
xlabel('t')
title('Mixed Signal 2')
subplot(2,2,3)
scatter(X(:,1),X(:,2),'.')
title('Scatter diagram 2-D')


%% (a1) ICA Without SVD

mdl1 = rica(X,2);  % ICA
W1 = mdl1.TransformWeights;
S1 = X*W1; % reconstructed signals

figure(3) % Plot reconstructed signals
suptitle('ICA without SVD')
subplot(2,2,1)
plot(S1(:,1))
title('ICA reconstructed s1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(S1(:,2))
ylabel('s2(t)')
xlabel('t')
title('ICA reconstructed s2')
subplot(2,2,3)
scatter(S1(:,1),S1(:,2),'.')
title('Scatter diagram 2-D')

%% (a2) ICA With SVD

X2 =Exercise6_4prewhiten(X);

mdl2 = rica(X2,2); % ICA
W2 = mdl2.TransformWeights;
S2 = X2*W2;

figure(4) % Plot S2
suptitle('ICA with SVD')
subplot(2,2,1)
plot(S2(:,1))
title('ICA reconstructed s1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(S2(:,2))
ylabel('s2(t)')
xlabel('t')
title('ICA reconstructed s2')
subplot(2,2,3)
scatter(S2(:,1),S2(:,2),'.')
title('Scatter diagram 2-D')

%% (b) Transform in R^3 

AA = [-0.1 0.3 -0.2;
    -2.5 -0.2 -0.3];

XX = S*AA; % Mix signals R^3

figure(5) % Plot mixed signals in R^3
subplot(2,2,1)
plot(XX(:,1))
title('Mixed Signal 1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(XX(:,2))
ylabel('s2(t)')
xlabel('t')
title('Mixed Signal 2')
subplot(2,2,3)
plot(XX(:,3))
ylabel('s3(t)')
xlabel('t')
title('Mixed Signal 3')
subplot(2,2,4)
scatter3(XX(:,1),XX(:,2),XX(:,3),'.')
title('Scatter diagram 3-D')

%% (b1) ICA Without SVD

mdl3 = rica(XX,2);  % ICA
WW1 = mdl3.TransformWeights;
SS1 = XX*WW1; % reconstructed signals

figure(6) % Plot reconstructed signals
suptitle('ICA without SVD')
subplot(2,2,1)
plot(SS1(:,1))
title('ICA reconstructed s1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(SS1(:,2))
ylabel('s2(t)')
xlabel('t')
title('ICA reconstructed s2')
subplot(2,2,3)
scatter(SS1(:,1),SS1(:,2),'.')
title('Scatter diagram 2-D')

%% (b2) ICA With SVD

XX2 = Exercise6_4prewhiten(XX);

mdl4 = rica(XX2,2); % ICA
WW2 = mdl4.TransformWeights;
SS2 = XX2*WW2;

figure(7) % Plot SS2
suptitle('ICA with SVD')
subplot(2,2,1)
plot(SS2(:,1))
title('ICA reconstructed s1')
ylabel('s1(t)')
xlabel('t')
subplot(2,2,2)
plot(SS2(:,2))
ylabel('s2(t)')
xlabel('t')
title('ICA reconstructed s2')
subplot(2,2,3)
scatter(SS2(:,1),SS2(:,2),'.')
title('Scatter diagram 2-D')
