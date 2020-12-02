%Question2
clc
clear

deltaX = 1/1000;
deltaT = 2*10^(-5);
sig = 4;
T = 0.05;
%number of mesh points
N = 1./deltaX + 1;

%x and t points
x = [0:deltaX:1];
t = [0:deltaT:T];
%initial conditions

for m = 0:50
    u(:,m+1) = (-1)^m * 40 /((2 * m + 1).^2*pi.^2).*sin((2 * m + 1)*pi.*x);
end

for i=1:length(x)
    uValues(:,i) = sum(u(i,:));
end

%plot the initial conditions
plot(x,uValues);
grid on
xlabel('x');
ylabel('u');
title('Initial Conditions');
hold off

%Thomas algorithms
k = sig*deltaT/deltaX^2;
a = ones(N-1,1)*(-k);
a(1)=0;
b = ones(N-1,1)*(1+2*k);
b(N-1,1) = 1;
c = ones(N-1,1)*(-k);
c(N-2,1) = -1;
c(N-1)=0;

for i = 1:length(t)
    for m = 0:1:50
        uSingle(m+1,:) = (((-1)^m) * 40 / ((2 * m + 1)^2*pi^2)).*sin((2 * m + 1)*pi.*x).*exp(-sig*(2*m + 1)^2*pi^2*t(i));
    end
    %for each t
    uAll(i,:) = sum(uSingle,1);
    
    %Derichlet
    alphaD = 0;
    %neumann
    betaN = 0;
    %du/dx to calculate Neumann
    for m = 0:1:50
        betaN = betaN + (-1)^(m+1)*40/((2*m+1)*pi)*exp(-sig*(2*m+1)^2*pi^2*t(i));
    end

    %forward
    beta(i,1) = b(1);
    %for u starts from the first row
    gamma(i,1) = uValues(i,1)/beta(1);
    for k = 2:N-1
        beta(i,k) = b(k)-a(k)*c(k-1)/beta(i,k-1);
        gamma(k) = (-a(k)*gamma(i,k-1)+uValues(i,k))/beta(i,k);
    end
    
    %backward
    uNum(i,N-1) = gamma(i,N-1); 
    for j = N-2:-1:1
        uNum(i,j) = gamma(i,j)-(uValues(i,j+1)*c(j))/beta(i,j);
    end 
    uValues(i+1,:) = [0,uNum(i,:)];
end

uNum = [zeros(length(t),1),uNum];

for i = 1:length(t)
    plot(x,uNum(i,:));
    hold on
end
hold off







