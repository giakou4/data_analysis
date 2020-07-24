%4-2
%% Data: measurement uncertainty for each dimension
sX1 = 5;
sX2 = 5;
%% [a]
disp(['[a]'])
%sY = df/dX1 * sX1^2 + df/dX2 *sX2^2 = x2^2 * sX1^2 + x1^2 * sX2^2
x1 = 500;
x2 = 300;
sY = sqrt((x2^2)*(sX1^2)+(x1^2)*(sX2^2));
disp(['Measurement uncertainty of (x1,x2)=(',num2str(x1),',',num2str(x2),') is ',num2str(sY),' metres'])
%% [b] 
disp(['[b]'])
disp(['Check figure'])
clf
%values to check
v = 0:1:1000;
%create values
[X1,X2] = meshgrid(v,v);
Z = (sX1^2)*(X2^2)+(sX2^2)*(X1^2);
surf(X1,X2,Z,'edgecolor','none')
xlabel('Width')
ylabel('Length')
zlabel('Measurement uncertainty')
rotate3d on