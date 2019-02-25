%this function aims at accepting x,y data and output the polynomial
%coefficients between any two points.
%This function named CubicIn should accept two arrays x and fx.

function polyArray=CubicIn(x,fx)
n=length(x);
m(1)=0;
m(n)=0;

for i=1:n
    a(i)=fx(i);
   
end
for j=1:(n-1)
    h(j)=x(j+1)-x(j);
end





