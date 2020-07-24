%% Info
% Group 04
% Nikolaos Giakoumoglou
% AEM: 9043
%% Data
clc; clear all; close all;
X = importdata('forestfires.dat');
B = 1000;
alpha = 0.5;
%% PCA
[n p] = size(X);
Y = X - mean(X);
Y = Y./std(Y);
[EVECTOR,EVALUE]=eig(cov(Y));
EVALUE = diag(EVALUE); 
EVALUE = flipud(EVALUE);
EVECTOR = EVECTOR(:,p:-1:1);

%% Scree plot
figure(1)
plot(EVALUE,'--o')
hold on
plot([0 p+1],mean(EVALUE)*[1 1],'-')
title('Scree plot')
xlabel('index')
ylabel('eigenvalue')

d = length(find(EVALUE>mean(EVALUE)));

%% Randomization
EVALUES = NaN*ones(p,B);
for i=1:B
    idx = unidrnd(n,n,1);
    Xrandom = X(idx,:);
    [n p] = size(Xrandom);
    Yrandom = Xrandom - mean(Xrandom);
    Yrandom = Yrandom./std(Yrandom);
    [evector,evalue]=eig(cov(Yrandom));
    evalue = diag(evalue); 
    evalue = flipud(evalue);
    evector = evector(:,p:-1:1);
    EVALUES(:,i) = evalue;
end

d2 = 0;
figure(2)
clf;
suptitle('Empirical distribution of eigenvalues')
for i=1:p   
    subplot(4,4,i)
    [counts,centers] = hist(EVALUES(i,:));
    bar(centers,counts)
    title(sprintf('Eigenvalue %.0f',i))
    hold on
    plot(EVALUE(i)*[1 1],[0 1.1*max(counts)],'r','LineWidth',3)
    
    EVALUES(i,:) = sort(EVALUES(i,:));
    [~,pos] = min(abs(EVALUE(i) - EVALUES(i,:)));
    if pos>(1-alpha/2)*B
        d2 = d2 + 1;
    end
end