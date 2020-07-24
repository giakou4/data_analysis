%% 6-1
%% Data
clc; close all; clear all;
n = 1000;
W = [0.2 0.8;
    0.4 0.5;
    0.7 0.3]; %mixing matrix
X = mvnrnd([0 0],[1 0;0 4],n);
XX = X*W';
%% Show the points in 2-D
figure(1)
plot(X(:,1),X(:,2),'.');
xlabel('x1')
ylabel('x2')
title('2D Gaussian generated points')

%% Show the points in 3-D
figure(2)
clf
plot3(XX(:,1),XX(:,2),XX(:,3),'.')
xlabel('y1')
ylabel('y2')
ylabel('y3')
title('3D observed points')

%% Find eigenvalues and eigenvectors of covariance matrix Y 
[n p] = size(XX);
Y = XX - repmat(sum(XX)/n,n,1);
[EVECTOR,EVALUE]=eig(cov(Y)); % Calculate eigenvectors V and eigenvalues D
EVALUE = diag(EVALUE); 
EVECTOR = flipud(EVECTOR);
EVALUE = flipud(EVALUE); % Order in descending order
EVECTOR = EVECTOR(:,p:-1:1);

%% Scree plot
figure(3)
plot(EVALUE,'--o')
title('Scree plot')
xlabel('index')
ylabel('eigenvalue')

%% Generate PCA compenent space (PCA scores)
score = (EVECTOR*Y')'; 

figure(4)
plot3(score(:,1),score(:,2),score(:,3),'.k')
title('Principal Componenent Scores')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
rotate3d on
%%  Plot first 2 PC
figure(5)
score2 = (EVECTOR(1:2,:)*Y')';
plot(score2(:,1),score2(:,2),'.k')
title('Principal Componenent Scores')
xlabel('PC1')
ylabel('PC2')