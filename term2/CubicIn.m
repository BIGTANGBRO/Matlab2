%this function aims at accepting x,y data and output the polynomial
%coefficients between any two points.
%This function named CubicIn should accept two arrays x and fx.

function polyArray=CubicIn(x,fx)

n=length(x);
m=[];
m(1)=0;
m(n)=0;
mat_h=zeros(n,n*4);
y=zeros(n-2,1);

for i=1:n
    a(i)=fx(i);
   
end
for j=1:(n-1)
    h(j)=x(j+1)-x(j);
end
for k=1:(n-2)
    mat_h(k,-2+3*k:3*k)=[h(k),h(k)+h(k+1),h(k+1)];
end
mat_h_edit=mat_h(:,2:3*k-1);
for num =2:n-1
    y(num-1,1)=6*((fx(num+1)-fx(num))/h(num)-(fx(num)-fx(num-1))/h(num-1));
end
mat_m=mat_h_edit.^(-1)*y;
for number=2:n-1
    m(number-1,1)=mat_m(number*3-4);
end

    
    

