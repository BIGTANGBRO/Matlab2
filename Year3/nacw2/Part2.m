%4th order Runge-Kutta
clear
clc

a=1;
b=0.5;
q=1;
r=1;
s=10;
T=20;
h=0.01;
n=(T/h);
P2(1)=s;
for i=1:n
    k1=h*-(2*P2(i)+q-(b^2/r)*(P2(i))^2);
    k2=h*-(2*(P2(i)+1/2*k1)+q-(b^2/r)*(P2(i)+1/2*k1)^2);
    k3=h*-(2*(P2(i)+1/2*k2)+q-(b^2/r)*(P2(i)+1/2*k2)^2);
    k4=h*-(2*(P2(i)+k3)+q-(b^2/r)*(P2(i)+k3)^2);
    P2(i+1)=P2(i)+(1/6)*k1+(1/3)*(k2+k3)+(1/6)*k4;  
end
P2ss=P2(n+1);
P2(1)=0;
for i=1:n
    k1=h*-(2*P2(i)+q-(b^2/r)*(P2(i))^2);
    k2=h*-(2*(P2(i)+1/2*k1)+q-(b^2/r)*(P2(i)+1/2*k1)^2);
    k3=h*-(2*(P2(i)+1/2*k2)+q-(b^2/r)*(P2(i)+1/2*k2)^2);
    k4=h*-(2*(P2(i)+k3)+q-(b^2/r)*(P2(i)+k3)^2);
    P2(i+1)=P2(i)+(1/6)*k1+(1/3)*(k2+k3)+(1/6)*k4;
    
end
P2s0=P2(n+1);

P2(1)=8;
while abs(P2(n+1)-s)>=10^(-8)
     P2(1)=P2(1)+(s-0)/(P2ss-P2s0)*(10^(-8));
for i=1:n;
    k1=h*-(2*P2(i)+q-(b^2/r)*(P2(i))^2);
    k2=h*-(2*(P2(i)+1/2*k1)+q-(b^2/r)*(P2(i)+1/2*k1)^2);
    k3=h*-(2*(P2(i)+1/2*k2)+q-(b^2/r)*(P2(i)+1/2*k2)^2);
    k4=h*-(2*(P2(i)+k3)+q-(b^2/r)*(P2(i)+k3)^2);
    P2(i+1)=P2(i)+(1/6)*k1+(1/3)*(k2+k3)+(1/6)*k4;
  
end
end
P2trueo=P2(1)

%%
P2(1)=P2trueo;
X(1)=5
for i=1:n
    X(i+1)=X(i)+h*a*X(i)-((b^2)/r)*h*P2(i)*X(i)
    k1=h*-(2*P2(i)+q-(b^2/r)*(P2(i))^2);
    k2=h*-(2*(P2(i)+1/2*k1)+q-(b^2/r)*(P2(i)+1/2*k1)^2);
    k3=h*-(2*(P2(i)+1/2*k2)+q-(b^2/r)*(P2(i)+1/2*k2)^2);
    k4=h*-(2*(P2(i)+k3)+q-(b^2/r)*(P2(i)+k3)^2);
    P2(i+1)=P2(i)+(1/6)*k1+(1/3)*(k2+k3)+(1/6)*k4;
end
subplot(2,1,1);
plot(([1:2001]-1)/100,X,'bx-')
xlabel('time/s')
ylabel('x(t)')
title('Numerical solutions of x(t)')

subplot(2,1,2);
plot(([1:2001]-1)/100,P2,'rx-')

xlabel('time/s')
ylabel('p(t)')
title('Numerical solutions for p(t)')