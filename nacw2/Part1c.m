clear
clc
%explicit Euler
a=1;
b=0.5;
q=1;
r=1;
s=10;
T=20;
h=0.25;
n=T/h;
P(1)=s;
for i=1:n
    P(i+1)=P(i)+h*(2*P(i)+q-(b^2/r)*(P(i))^2);
end
P=flip(P);

%4th order Runge-Kutta
a=1;
b=0.5;
q=1;
r=1;
s=10;
T=20;
h=0.25;
n=T/h;
P2(1)=s;
for i=1:n
    k1=h*(2*P2(i)+q-(b^2/r)*(P2(i))^2);
    k2=h*(2*(P2(i)+1/2*k1)+q-(b^2/r)*(P2(i)+1/2*k1)^2);
    k3=h*(2*(P2(i)+1/2*k2)+q-(b^2/r)*(P2(i)+1/2*k2)^2);
    k4=h*(2*(P2(i)+k3)+q-(b^2/r)*(P2(i)+k3)^2);
    P2(i+1)=P2(i)+(1/6)*k1+(1/3)*(k2+k3)+(1/6)*k4;
    
end
P2=flip(P2);

plot([0:80]/4,P,'rx-')
hold on
plot([0:80]/4,P2,'bo-')
xlabel('t/s');
ylabel('p(t)');
title('Numerical solutions to the ODE')
legend('Explicit Euler',...
    '4th order Runge-Kutta')


figure
X(1)=5
for i=1:n
    X(i+1)=X(i)+h*a*X(i)-((b^2)/r)*h*P2(i)*X(i)
end
plot([0:80]/4,X,'bx-')
xlabel('time/s');
ylabel('x(t)');
title('The explicit solution to the ODE')
