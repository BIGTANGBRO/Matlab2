clear
clc

climb_angle=atan(asin(0.5*0.35-0.21/2.6));%drag 0.21

m =linspace(0,0.9);%0:0.1:0.9; %linspace(0,0.9)
h =linspace(0,14000);%0:500:13000;%linspace(0,13000)
[M,H] = meshgrid(m,h);
Ae=9.4*(0.8);

W0=144554.8*9.8;
W_W0=0.97;%W1/W0
T0_W0=0.35;
W0_Sref=4700;
W_Sref=W_W0*W0_Sref;
g0=9.81;
R=287;
h0=0;
h1=11000;
P0=101325;
rho0=1.225;
lamda0=-0.0065;
lamda1=0;
T0=288.15;
T1=216.65;
BPR=9.1;
gamma=1.4;
Sref=301;
n=1;
%delta P/P0
for i=1:length(h)
    for j=1:length(m)
    if h(i) < 11000
        delta(i,j)=(1+(lamda0/T0)*h(i))^(-g0/(R*lamda0));
    else
        delta(i,j)=(1+(lamda0/T0)*h(i))^(-g0/(R*lamda0));
        %delta(i,j)=exp(-g0*(h(i)-h1)/(R*T1));
    end
    end
end

%sigma rho/rho0
for i=1:length(h)
    for j=1:length(m)
    if h(i) < 11000
        sigma(i,j)=(1+(lamda0/T0)*h(i))^-(1+(g0/(R*lamda0)));
    else
        %sigma(i,j)=exp(-g0*(h(i)-h1)/(R*T1));
        sigma(i,j)=(1+(lamda0/T0)*h(i))^-(1+(g0/(R*lamda0)));
    end
    end
end
    
%thrust
for i=1:length(h)
    for j=1:length(m)
T_T0(i,j)=(0.88-0.016*BPR-0.3*m(j));
if m(j)<0.7
CD0(i,j)=0.022;
else
CD0(i,j)=0.022+(0.0182*m(j)-0.0127);   
end
    end
end
T_T0=T_T0.*(sigma.^0.7);

Clmax=1.2;
%Vstall
for i=1:length(h)
    sigma1(i)=(1+(lamda0/T0)*h(i))^-(1+(g0/(R*lamda0)));
    delta1(i)=(1+(lamda0/T0)*h(i))^(-g0/(R*lamda0));
    vstall(i)=sqrt(W0/Clmax/0.5/(rho0*sigma1(i))/Sref);
    vstall(i)=vstall(i)/(340*sqrt(delta1/sigma1));
end
    
%P = M *( sqrt(gamma*P0/rho0*(delta/sigma)) )*(  )
gamma=gamma*ones(length(h),length(m));
P0=P0*ones(length(h),length(m));
rho0=rho0*ones(length(h),length(m));
T0=T0*ones(length(h),length(m));
W_Sref=W_Sref*ones(length(h),length(m));
pai=pi*ones(length(h),length(m));
Ae=Ae*ones(length(h),length(m));
C=T_T0.*(T0_W0)*((W_W0)^(-1));
E=(CD0.*(rho0/2).*sigma.*(M.*sqrt(gamma.*(P0./rho0).*(delta./sigma))).^2)./W_Sref;
F=(n^2*W_Sref)./((rho0/2).*sigma.*((M.*sqrt(gamma.*(P0./rho0).*(delta./sigma))).^2).*pai.*Ae);
D=E+F;
B=C-D;
P=M.*(sqrt(gamma.*(P0./rho0).*(delta./sigma))).*B;
vals=[0:1.:30];

figure(1);
[c1,h1]=contour(M,H,P,vals);
clabel(c1,h1);
title('Specific Excess Power');
xlabel('Mach number');
ylabel('Altitude (m)');
hold on
plot (vstall,h,'-r');
hold on
plot(0.8,10668,'x');
hold on
plot(ones(length(h))*0.82,h,'--b');
hold on
plot(m,ones(length(m))*12801),'--m';
legend('Specific Excess Power','Stall boundary','Cruising point',...
    'Maximum speed','Absolute Ceiling');

