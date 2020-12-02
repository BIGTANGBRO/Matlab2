clear
clc

sigma=4;
dt=2e-5;
dx=1/50;
N=1/dx+1; %Number of mesh points
T=0.05;

%Initial conditions u(x,0)
x=0:dx:1;

for i=1:length(x)
    um=0;
    for m=0:50
        M=(-1)^m*(40/((2*m+1)^2*pi^2))*sin((2*m+1)*pi*x(i));
        um=um+M;
    end
    u(i)=um;
end


K=sigma*dt/(dx^2);
%Creating tri-diagonal matrix
a=-K;
b=1+2*K;
c=-K;
A=(diag(b*ones(1,N))+diag(c*ones(1,N-1),1)+diag(a*ones(1,N-1),-1));

t=1;
for i=0:dt:T
    
    beta(t,1)=A(1,1);
    gamma(t,1)=u(t,1)/beta(t,1);
    
    %Forward step
    for k=2:N
        beta(t,k)=A(k,k)-A(k,k-1)*(A(k-1,k)/beta(t,k-1));
        gamma(t,k)=(-A(k,k-1)*gamma(t,k-1)+u(t,k))/beta(t,k);
    end
    %Backward step
    ut(t,N)=gamma(t,N);
    for k=N-1:-1:1
        ut(t,k)=gamma(t,k)-ut(t,k+1)*A(k,k+1)/beta(t,k);
    end
    u(t+1,:)=ut(t,:);
    t=t+1;
    
end

for i=1:t
    plot(x,u(i,:))
    hold on
end

