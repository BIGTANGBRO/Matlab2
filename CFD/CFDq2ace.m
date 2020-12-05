%Question2
clc
clear

deltaX = 1/500;
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
%save the initial conditions
uInitial(:,:) = uValues(:,:);
%plot the initial conditions
figure(1);
% plot(x,uValues);
% grid on
% xlabel('x');
% ylabel('u');
% title('Initial Conditions');
% hold off

%Thomas algorithms
k = sig*deltaT/deltaX^2;
a = ones(N-1,1)*(-k);
a(1)=0;
a(N-1) = -1;
b = ones(N-1,1)*(1+2*k);
b(N-1,1) = 1;
c = ones(N-1,1)*(-k);
c(N-1)=0;

for i = 2:length(t)
    for m = 0:1:50
        uSingle(m+1,:) = (((-1)^m) * 40 / ((2 * m + 1)^2*pi^2)).*sin((2 * m + 1)*pi.*x).*exp(-sig*(2*m + 1)^2*pi^2*t(i));
    end
    %for each t
    uAll(i-1,:) = sum(uSingle,1);
    
    %Derichlet
    alphaD = 0;
    %neumann
    betaN = 0;
    %du/dx to calculate Neumann
    for m = 0:1:50
        betaN = betaN + (-1)^(m+1)*40/((2*m+1)*pi)*exp(-sig*(2*m+1)^2*pi^2*t(i));
    end
    
    uValues(i-1,N) = deltaX*betaN;
    
    %forward
    beta(i-1,1) = b(1);
    %for u starts from the first row
    gamma(i-1,1) = uValues(i-1,2)/beta(i-1,1);
    for k = 2:N-1
        beta(i-1,k) = b(k)-a(k)*c(k-1)/beta(i-1,k-1);
        gamma(i-1,k) = (-a(k)*gamma(i-1,k-1)+uValues(i-1,k+1))/beta(i-1,k);
    end
    
    %backward
    uNum(i-1,N-1) = gamma(i-1,N-1);
    for j = N-2:-1:1
        uNum(i-1,j) = gamma(i-1,j)-(uNum(i-1,j+1)*c(j))/beta(i-1,j);
    end 
    uValues(i,:) = [0,uNum(i-1,:)];
end
uNum = [zeros(length(t)-1,1),uNum];
uNum = [uInitial;uNum];
uAll = [uInitial;uAll];

%numerical solution
for i = 1:length(t)
    plot(x,uNum(i,:));
    hold on
end
grid on
title('plot of numerical solution for each t');
xlabel('x');
ylabel('u');
hold off

%substitute initial conditions
%uNum(1,:) = uInitial;
%plot 3d graph
figure(3)
mesh(x,t,uNum);
hold off
grid on
title('3d plot of final solution and initial condition');
ylabel('t');
xlabel('x');
zlabel('u')
hold off

%exact solution
figure(2)
for i = 1:length(t)
    plot(x,uAll(i,:));
    hold on
end
grid on
title('plot of exact solution for each t');
xlabel('x');
ylabel('u');
hold off




