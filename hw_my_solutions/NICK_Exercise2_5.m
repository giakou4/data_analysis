% 2-5
%   X ~ N(4, 0.01) 
%   if x<3.9 -> rejected
%   a = find probability of rejected P(X<3.9) 
%   b = find k so as P(X<k)=0.01

a = normcdf(3.9, 4, 0.1);
A=['P(X<3.9)= ', num2str(a)];
disp(A)

b=norminv(0.01,4,0.1);
B=['P(X<k)=0.01 => k= ',num2str(b)];
disp(B)



