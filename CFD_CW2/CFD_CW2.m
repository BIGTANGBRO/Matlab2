%cfd coursework2
%author:Jiaxuan Tang 22/01/2021

clc
clear
close all;

gamma = 1.4;
xBegin = -2;
xEnd = 2;
%set the space
N1 = 100;
N2 = 200;
N3 = 300;

%% N = 100
%initial condition
denRatio = 8;
preRatio = 10;
%set the deltaX and deltaT
deltaX1 = 4/(N1-1);
dX1 = linspace(-2,2,N1);

deltaT = 0.005;
dT = [0:deltaT:0.5];

%initial conditions
rho1 = ones(1,length(dX1));
rho1(1:N1/2) = denRatio;
pressure1 = ones(1,N1);
pressure1(1:N1/2) = preRatio;
u1 = zeros(1,N1);
E1=pressure1./((gamma-1).*rho1)+u1.^2/2;
BigU1 = [rho1;rho1.*u1;rho1.*E1];

%iteration until t = 0.5;
for n = 1:length(dT)
    for i = 1:N1
        %initial value of u is 0;
        %for each dx
        mA1 = getMatrixA(u1(i),E1(i));
        %get F+;
        %get F-;   
        %2 methods
%method1
%get mach
         eigValues1(:,i) = sort(eig(mA1)); 
         cValue1(i) = eigValues1(3) - eigValues1(2);
%         uValue(i) = eigValues(2);
%         H = E+pressure./rho;
%          %from eig to get F+ F-

%         vPlus=0.5.*(eigValues+abs(eigValues));
%         vMinus=0.5.*(eigValues-abs(eigValues));
%         FPlus(:,i)=0.5*rho(i)/gamma.*[vPlus(1)+2*(gamma-1)*vPlus(2)+vPlus(3);eigValues(1)*vPlus(1)+2*(gamma-1)*u(i)*vPlus(2)+eigValues(3)*vPlus(3);(H(i)-u(i)*cValue(i))*vPlus(1)+(gamma-1)*u(i)^2*vPlus(2)+(H(i)+u(i)*cValue(i))*vPlus(3)];
%         FMinus(:,i)=0.5*rho(i)/gamma.*[vMinus(1)+2*(gamma-1)*vMinus(2)+vMinus(3);eigValues(1)*vMinus(1)+2*(gamma-1)*u(i)*vMinus(2)+eigValues(3)*vMinus(3);(H(i)-u(i)*cValue(i))*vMinus(1)+(gamma-1)*u(i)^2*vMinus(2)+(H(i)+u(i)*cValue(i))*vMinus(3)];
%         
%method 2
        mF = getMatrixF(rho1(i),u1(i),pressure1(i),E1(i));
        [eigenVectors,eigenValues] = eig(mA1);
        Vplus = 0.5.*(eigenValues + abs(eigenValues));
        Vminus = 0.5.*(eigenValues - abs(eigenValues));
        Aplus = eigenVectors * Vplus * inv(eigenVectors);
        Aminus = eigenVectors * Vminus * inv(eigenVectors);
        FPlus(:,i) = Aplus * BigU1(:,i);
        FMinus(:,i) = Aminus * BigU1(:,i);
    end
    
   %get the new Bigu
    for j = 2:N1-1 
        %BigU n+1 = BigU n + fun(F+,F-);
        BigU1(:,j) = BigU1(:,j) - (deltaT/deltaX1).*(FPlus(:,j)-FPlus(:,j-1)+FMinus(:,j+1)-FMinus(:,j));
        %update the big U
    end
    
    %get from U2 to Un-1, U2 = U1,Un = Un-1
    %get boundary conditions
    BigU1(:,1) = BigU1(:,2);
    BigU1(:,N1) = BigU1(:,N1-1); 
    %from BigU n +1,get new rho,v,pressure
    
    rho1(:) = BigU1(1,:);
    u1(:) = BigU1(2,:)./BigU1(1,:);
    E1(:) = BigU1(3,:)./BigU1(1,:);
    pressure1(:) = (gamma-1).*rho1.*(E1-0.5*u1.^2);
   
end
%get entropy
entropy1=log(pressure1./(rho1.^gamma));

%find maximum lambda to find limit of deltaT
for i = 1:N1
    Lambda1(i) = max(eigValues1(:,i));
end
maxLambda1 = max(Lambda1);
maxdeltaT1 = deltaX1/maxLambda1;
fprintf("The maximum delta T is %3.4f \n",maxdeltaT1);
machNum1 = u1./cValue1;

%% N=200
deltaX2 = 4/(N2-1);
dX2 = linspace(-2,2,N2);
rho2 = ones(1,length(dX2));
rho2(1:N2/2) = denRatio;
pressure2 = ones(1,N2);
pressure2(1:N2/2) = preRatio;
u2 = zeros(1,N2);
E2=pressure2./((gamma-1).*rho2)+u2.^2/2;
BigU2 = [rho2;rho2.*u2;rho2.*E2];

%iteration until t = 0.5;
for n = 1:length(dT)
    for i = 1:N2
        %initial value of u is 0;
        %for each dx
        mA2 = getMatrixA(u2(i),E2(i));
        %get F+;
        %get F-;   
        %get mach
        eigValues2(:,i) = sort(eig(mA2)); 
        cValue2(i) = eigValues2(3) - eigValues2(2);
        mF = getMatrixF(rho2(i),u2(i),pressure2(i),E2(i));
        [eigenVectors,eigenValues] = eig(mA2);
        Vplus = 0.5.*(eigenValues + abs(eigenValues));
        Vminus = 0.5.*(eigenValues - abs(eigenValues));
        Aplus = eigenVectors * Vplus * inv(eigenVectors);
        Aminus = eigenVectors * Vminus * inv(eigenVectors);
        FPlus(:,i) = Aplus * BigU2(:,i);
        FMinus(:,i) = Aminus * BigU2(:,i);
    end
    
   %get the new Bigu
    for j = 2:N2-1 
        %BigU n+1 = BigU n + fun(F+,F-);
        BigU2(:,j) = BigU2(:,j) - (deltaT/deltaX2).*(FPlus(:,j)-FPlus(:,j-1)+FMinus(:,j+1)-FMinus(:,j));
        %update the big U
    end
    
    %get from U2 to Un-1, U2 = U1,Un = Un-1
    %get boundary conditions
    BigU2(:,1) = BigU2(:,2);
    BigU2(:,N2) = BigU2(:,N2-1); 
    %from BigU n +1,get new rho,v,pressure
    
    rho2(:) = BigU2(1,:);
    u2(:) = BigU2(2,:)./BigU2(1,:);
    E2(:) = BigU2(3,:)./BigU2(1,:);
    pressure2(:) = (gamma-1).*rho2.*(E2-0.5*u2.^2);
end
%get entropy
entropy2=log(pressure2./(rho2.^gamma));

%find maximum lambda to find limit of deltaT
for i = 1:N2
    Lambda2(i) = max(eigValues2(:,i));
end
maxLambda2 = max(Lambda2);
maxdeltaT2 = deltaX2/maxLambda2;
fprintf("The maximum delta T is %3.4f \n",maxdeltaT2);
machNum2 = u2./cValue2;

%%
% N = 300;
deltaX3 = 4/(N3-1);
dX3 = linspace(-2,2,N3);
rho3 = ones(1,length(dX3));
rho3(1:N3/2) = denRatio;
pressure3 = ones(1,N3);
pressure3(1:N3/2) = preRatio;
u3 = zeros(1,N3);
E3=pressure3./((gamma-1).*rho3)+u3.^2/2;
BigU3 = [rho3;rho3.*u3;rho3.*E3];

%iteration until t = 0.5;
for n = 1:length(dT)
    for i = 1:N3
        %initial value of u is 0;
        %for each dx
        mA3 = getMatrixA(u3(i),E3(i));
        %get F+;
        %get F-;   
        %2 methods
        %get mach
        eigValues3(:,i) = sort(eig(mA3)); 
        cValue3(i) = eigValues3(3) - eigValues3(2);
        mF = getMatrixF(rho3(i),u3(i),pressure3(i),E3(i));
        [eigenVectors,eigenValues] = eig(mA3);
        Vplus = 0.5.*(eigenValues + abs(eigenValues));
        Vminus = 0.5.*(eigenValues - abs(eigenValues));
        Aplus = eigenVectors * Vplus * inv(eigenVectors);
        Aminus = eigenVectors * Vminus * inv(eigenVectors);
        FPlus(:,i) = Aplus * BigU3(:,i);
        FMinus(:,i) = Aminus * BigU3(:,i);
    end
    
   %get the new Bigu
    for j = 2:N3-1 
        %BigU n+1 = BigU n + fun(F+,F-);
        BigU3(:,j) = BigU3(:,j) - (deltaT/deltaX3).*(FPlus(:,j)-FPlus(:,j-1)+FMinus(:,j+1)-FMinus(:,j));
        %update the big U
    end
    
    %get from U2 to Un-1, U2 = U1,Un = Un-1
    %get boundary conditions
    BigU3(:,1) = BigU3(:,2);
    BigU3(:,N3) = BigU3(:,N3-1); 
    %from BigU n +1,get new rho,v,pressure
    
    rho3(:) = BigU3(1,:);
    u3(:) = BigU3(2,:)./BigU3(1,:);
    E3(:) = BigU3(3,:)./BigU3(1,:);
    pressure3(:) = (gamma-1).*rho3.*(E3-0.5*u3.^2);
end
%get entropy
entropy3=log(pressure3./(rho3.^gamma));

%find maximum lambda to find limit of deltaT
for i = 1:N3
    Lambda3(i) = max(eigValues3(:,i));
end
maxLambda3 = max(Lambda3);
maxdeltaT3 = deltaX3/maxLambda3;
fprintf("The maximum delta T is %3.4f \n",maxdeltaT3);
machNum3 = u3./cValue3;

%%
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
plot(dX1,u1,'--g');
hold on
plot(dX2,u2,'--r');
hold on
plot(dX3,u3,'-.b');
hold on
plot(xA,uA);
grid on
xlabel('x');
ylabel('Velocity');
legend("N=100","N=200","N=300","Analytical");
hold off

figure(2);
plot(dX1,pressure1,'-g');
hold on
plot(dX2,pressure2,'--r');
hold on
plot(dX3,pressure3,'-.b');
hold on
plot(xA,pA);
grid on
xlabel('x');
ylabel('Pressure');
legend("N=100","N=200","N=300","Analytical");
hold off

figure(3)
plot(dX1,rho1,'--g');
hold on
plot(dX2,rho2,'--r');
hold on
plot(dX3,rho3,'-.b');
hold on
plot(xA,rhoA);
grid on
xlabel('x');
ylabel('Density');
legend("N=100","N=200","N=300","Analytical");
hold off

figure(4)
plot(dX1,entropy1,'--g');
hold on
plot(dX2,entropy2,'--r');
hold on
plot(dX3,entropy3,'-.b');
grid on
hold on
plot(xA,entropyA);
xlabel('x');
ylabel('Entropy');
legend("N=100","N=200","N=300","Analytical");
hold off

figure(5)
plot(dX1,machNum1,'--g');
hold on
plot(dX2,machNum2,'--r');
hold on;
plot(dX3,machNum3,'-.b');
hold on
grid on
plot(xA,machA);
xlabel('x');
ylabel('Mach number');
legend("N=100","N=200","N=300","Analytical");
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

