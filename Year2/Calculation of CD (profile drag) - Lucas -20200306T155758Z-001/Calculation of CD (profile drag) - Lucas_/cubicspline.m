% CUBIC SPLINE CODE:

% inputs: vector of x values that you want to interpolate between (x),
% vector of y values corresponding to the x values (y)

function [xout,yout] = cubicspline(x,y)

% Initializing all arrays
n=length(x); % number of x points
h=zeros(1,n-1);
A=zeros(n-2); 
B=zeros(n-2,1); 
polyArray=zeros(n-1,4);

% Interval width
for i=1:n-1  
    h(i)=x(i+1)-x(i);
end

% Matrix A 
for j=1:n-2 
    A(j,j)=2*(h(j)+h(j+1)); % leading diagonal
end 
for k=1:n-3 
    A(k,k+1)=h(k+1); % diagonal above leading diagonal
    A(k+1,k)=h(k+1); % diagonal below leading diagonal
end 

% Matrix B 
for f=1:n-2
    B(f)=6*((y(f+2)-y(f+1))/h(f+1) - (y(f+1)-y(f))/h(f));
end 

% Solve matrix equation to determine curvature m at each point
m=A\B;
m=[0;m;0]; % Making m an Nx1 matrix

% Calculating the polynomial coefficients and placing them in polyArray
for p=1:n-1
    polyArray(p,1)=(m(p+1)-m(p))/(6*h(p)); % (x - xi)^3 coefficient 
    polyArray(p,2)=m(p)/2; % (x - xi)^2 coefficient
    polyArray(p,3)=(y(p+1)-y(p))/h(p)-h(p)*(2*m(p)+m(p+1))/6; % (x - xi) coefficient
    polyArray(p,4)=y(p); % constant coefficient 
end 

% Calculating the cubic spline values between the upper and lower bounds of x
f=@(t) polyArray(1,4) + polyArray(1,3)*(t-x(1)) + polyArray(1,2)*(t-x(1)).^2 + polyArray(1,1)*(t-x(1)).^3;
x2 = [x(1):0.01:x(2)];
y2 = f(x2);
for k=2:n-1
     f=@(t) polyArray(k,4) + polyArray(k,3)*(t-x(k)) + polyArray(k,2)*(t-x(k)).^2 + polyArray(k,1)*(t-x(k)).^3;
     x1 = [x(k):0.001:x(k+1)];
     y1 = f(x1);
     x2 = [x2,x1];
     y2 = [y2,y1];
end
xout = x2;
yout = y2;
end 