%this function aims at accepting x,y data and output the polynomial
%coefficients between any two points.
%This function named CubicIn should accept two arrays x and fx.

function polyArray=CubicIn(x,fx)%create the function with input of x and y.
n=length(x);%find the length of the array
m=zeros(n,1);%create the array with zeros used after as both the initial and the last values are zero
mat_h=zeros(n-2);%create the matrix for the collection of h as majority part is zero
for i=1:(n-1)
    h(i)=x(i+1)-x(i);%get the interval(can be improved by array operations)
end



for num1=2:n-1
    y(num1-1,1)=6*((fx(num1+1)-fx(num1))/h(num1)-(fx(num1)-fx(num1-1))/h(num1-1));%create the matrix for the f and h, which are in the equation of h and m
end
mat_h(1,1:2)=[2*(h(2)-h(1)),h(2)];
mat_h(n-2,n-3:n-2)=[h(n-2),2*(h(n-2)+h(n-1))];%the first and the last row are special as it eliminates h1 and h8 as the m1 and mN are both zero so there are 2 values in that row
for num2=3:n-2
    mat_h(num2-1,(num2-2):num2)=[h(num2-1) 2*(h(num2-1)+h(num2)) h(num2)];%fill the value in the matrix with hi-1, 2*(hi-1+hi) and hi
end



m(2:n-1,1)=mat_h\y;%solve the m by array operations from 2 to n-1 as 1 and n are both 0
for num3=1:n-1
    b(num3,1)=(fx(num3+1)-fx(num3))/h(num3)-h(num3)*(2*m(num3,1)+m(num3+1,1))/6;
    c(num3,1)=m(num3,1)/2;
    d(num3,1)=(m(num3+1,1)-m(num3,1))/(6*h(num3));
end%just use loops to fill the arguments
polyArray=[d,c,b,fx(1:n-1)'];%the output is a N-1x4 array as there are n-1 intervals
end


