%this function aims at accepting x,y data and output the polynomial
%coefficients between any two points.
%This function named CubicIn should accept two arrays x and fx.

function polyArray=CubicIn(x,fx)
n=length(x);
m=zeros(n,1);
mat_h=zeros(n-2);
for j=1:(n-1)
    h(j)=x(j+1)-x(j);
end



for num=2:n-1
    y(num-1,1)=6*((fx(num+1)-fx(num))/h(num)-(fx(num)-fx(num-1))/h(num-1));
end
mat_h(1,1:2)=[2*(h(2)-h(1)),h(2)];
mat_h(n-2,n-3:n-2)=[h(n-2),2*(h(n-2)+h(n-1))];
for numbers=3:n-2
    mat_h(numbers-1,(numbers-2):numbers)=[h(numbers-1) 2*(h(numbers-1)+h(numbers)) h(numbers)];
end



m(2:n-1,1)=mat_h\y;
for k=1:n-1
    a(k,1)=fx(k);
    b(k,1)=(fx(k+1)-fx(k))/h(k)-h(k)*(2*m(k,1)+m(k+1,1))/6;
    c(k,1)=m(k,1)/2;
    d(k,1)=(m(k+1,1)-m(k,1))/(6*h(k));
end
polyArray=[d,c,b,a];
end


