%cfd coursework2
%author:Jiaxuan Tang 22/01/2021

clc
clear
close all;

gamma = 1.4;
xBegin = -2;
xEnd = 2;
%set the space
N = 300;

%initial condition
denRatio = 8;
preRatio = 10;
%set the deltaX and deltaT
deltaX = 4/(N-1);
dX = linspace(-2,2,N);

deltaT = 0.005;
dT = [0:deltaT:0.5];

%initial conditions
rho = ones(1,length(dX));
rho(1:N/2) = denRatio;
pressure = ones(1,N);
pressure(1:N/2) = preRatio;
u = zeros(1,N);
E=pressure./((gamma-1).*rho)+u.^2/2;
BigU = [rho;rho.*u;rho.*E];

%iteration until t = 0.5;
for n = 1:length(dT)
    for i = 1:N
        %initial value of u is 0;
        %for each dx
        mA = getMatrixA(u(i),E(i));
        %get F+;
        %get F-;   
        %2 methods
%method1
        %get mach
         eigValues(:,i) = sort(eig(mA)); 
         cValue(i) = eigValues(3) - eigValues(2);
%         uValue(i) = eigValues(2);
%         H = E+pressure./rho;
%          %from eig to get F+ F-

%         vPlus=0.5.*(eigValues+abs(eigValues));
%         vMinus=0.5.*(eigValues-abs(eigValues));
%         FPlus(:,i)=0.5*rho(i)/gamma.*[vPlus(1)+2*(gamma-1)*vPlus(2)+vPlus(3);eigValues(1)*vPlus(1)+2*(gamma-1)*u(i)*vPlus(2)+eigValues(3)*vPlus(3);(H(i)-u(i)*cValue(i))*vPlus(1)+(gamma-1)*u(i)^2*vPlus(2)+(H(i)+u(i)*cValue(i))*vPlus(3)];
%         FMinus(:,i)=0.5*rho(i)/gamma.*[vMinus(1)+2*(gamma-1)*vMinus(2)+vMinus(3);eigValues(1)*vMinus(1)+2*(gamma-1)*u(i)*vMinus(2)+eigValues(3)*vMinus(3);(H(i)-u(i)*cValue(i))*vMinus(1)+(gamma-1)*u(i)^2*vMinus(2)+(H(i)+u(i)*cValue(i))*vMinus(3)];
%         

%method 2
        mF = getMatrixF(rho(i),u(i),pressure(i),E(i));
        [eigenVectors,eigenValues] = eig(mA);
        Vplus = 0.5.*(eigenValues + abs(eigenValues));
        Vminus = 0.5.*(eigenValues - abs(eigenValues));
        Aplus = eigenVectors * Vplus * inv(eigenVectors);
        Aminus = eigenVectors * Vminus * inv(eigenVectors);
        FPlus(:,i) = Aplus * BigU(:,i);
        FMinus(:,i) = Aminus * BigU(:,i);
    end
    
   %get the new Bigu
    for j = 2:N-1 
        %BigU n+1 = BigU n + fun(F+,F-);
        BigU(:,j) = BigU(:,j) - (deltaT/deltaX).*(FPlus(:,j)-FPlus(:,j-1)+FMinus(:,j+1)-FMinus(:,j));
        %update the big U
    end
    
    %get from U2 to Un-1, U2 = U1,Un = Un-1
    %get boundary conditions
    BigU(:,1) = BigU(:,2);
    BigU(:,N) = BigU(:,N-1); 
    %from BigU n +1,get new rho,v,pressure
    
    rho(:) = BigU(1,:);
    u(:) = BigU(2,:)./BigU(1,:);
    E(:) = BigU(3,:)./BigU(1,:);
    pressure(:) = (gamma-1).*rho.*(E-0.5*u.^2);
   
end
%get entropy
entropy=log(pressure./(rho.^gamma));

%find maximum lambda to find limit of deltaT
for i = 1:N
    Lambda(i) = max(eigValues(:,i));
end
maxLambda = max(Lambda);
maxdeltaT = deltaX/maxLambda;
fprintf("The maximum delta T is %3.4f",maxdeltaT);

%import the analytical solution
analyticalSol = importdata('shock_analytic.dat');
xA = analyticalSol.data(:,1);
rhoA = analyticalSol.data(:,2);
pA = analyticalSol.data(:,3);
uA = analyticalSol.data(:,4);
machA = analyticalSol.data(:,5);
entropyA = analyticalSol.data(:,6);

%plot section
figure(1);
plot(dX,u,'--');
hold on
plot(xA,uA);
grid on
xlabel('x');
ylabel('Velocity');
legend("numerical","Analytical")
title('N = 200');
hold off

figure(2);
plot(dX,pressure,'--');
hold on
plot(xA,pA);
grid on
xlabel('x');
ylabel('Pressure');
legend("numerical","Analytical")
title('N = 200');
hold off

figure(3)
plot(dX,rho,'--');
hold on
grid on
plot(xA,rhoA);
xlabel('x');
ylabel('Density');
legend("numerical","Analytical")
title('N = 200');
hold off

figure(4)
plot(dX,entropy,'--');
hold on
grid on
plot(xA,entropyA);
xlabel('x');
ylabel('Entropy');
legend("numerical","Analytical")
title('N = 200');
hold off

figure(5)
machNum = u./cValue;
plot(dX,machNum,'--');
hold on
grid on
plot(xA,machA);
xlabel('x');
ylabel('Mach number');
legend("numerical","Analytical")
title('N = 200');
hold off

%functions
%matrix function handler for matrixA
function matrixA = getMatrixA(u,E)
    gamma = 1.4;
    matrixA = [0,1,0;
        0.5*(gamma-3)*u^2,(3-gamma)*u,gamma-1
        (gamma-1)*u^3-gamma*u*E,gamma*E-0.5*3*(gamma-1)*u^2,gamma*u];
end

function matrixF = getMatrixF(rho,u,pressure,E)
    matrixF= [rho*u;rho*u^2+pressure;rho*u*(E+pressure/rho)];
end

