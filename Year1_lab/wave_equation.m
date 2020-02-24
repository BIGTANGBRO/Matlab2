clc
clear;
nSteps=2100;
dt=0.3;
c1=0.1;
c2=1.0;
w=20;
nx=500;
a(1:nx)=0;
v(1:nx)=0;
for i=1:nx
    r=(i-nx/2);
    z(i)=2*exp(-(r/w)^2)-exp(-(r/(2*w))^2);
end
for step=0:nSteps
    for i=2:nx-1
        z(i)=z(i)+v(i)*dt;
    end
    for i=2:nx-1
        a(i)=c2/c1*(z(i-1)-2*z(i)+z(i+1));
    end
    for i=2:nx-1
        v(i)=v(i)+a(i)*dt;
    end
    if (mod(step,2)==0)
        plot(z,'Linewidth',3);axis([1 nx -1 1])
        pause(0.001);
        if (step==0);pause();end
    end
end

