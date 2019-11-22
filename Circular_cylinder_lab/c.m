clear
clc

D1=load('First.mat');
D2=load('second.mat');
D3=load('Third.mat');
D4=load('Forth.mat');
D1=table2array(D1.first);
D2=table2array(D2.Second);
D3=table2array(D3.Third);
D4=table2array(D4.Fourth);

g=9.81;
rho=789; 
pitch=20*pi/180;
%V=[19.3,30.1,19.8,30.05];
V(1)=sqrt((8.55-6.05).*rho.*g.*sin(pitch).*0.0254.*2./1.225);
V(2)=sqrt((8.6-2.6).*rho.*g.*sin(pitch).*0.0254.*2./1.225);
V(3)=sqrt((8.9-6.35).*rho.*g.*sin(pitch).*0.0254.*2./1.225);
V(4)=sqrt((9.4-3.4).*rho.*g.*sin(pitch).*0.0254.*2./1.225);
%use the pressure difference to calculate the free speed.

hm=[D1(2:28,3),D2(2:28,3),D3(2:28,3),D4(2:28,3)];
angle_measure=D1(2:28,2);
hf=[8.55,8.6,8.9,9.4];
theta_rad=deg2rad(angle_measure);
theta_a=angle_measure;

%iterate through each case from 1 to 4
for time=1:4
    Re(time)=1.225*V(time)*0.102/(1.79*10^(-5));
    Cp(:,time)=(hf(time)-hm(:,time)).*rho.*g.*sin(pitch).*0.0254./(0.5*1.225*V(time).^2);
   
    CD(time)=trapz(theta_rad,Cp(:,time).*cos(theta_rad));
    %this is the incorrected CD
    
    %wall interference correction
    ratio=0.102/0.46;
    
    V_corrected(:,time)=V(time).*(1+0.25.*CD(time).*ratio+0.82.*ratio^2);
    Cp_corrected(:,time)=1+((V_corrected(time)./V(time)).^2).*(Cp(:,time)-1);
    
    CD_corrected(time)=trapz(theta_rad,Cp_corrected(:,time).*cos(theta_rad));
    %direct corrected CD;
    CD_eqn(time)=CD(time).*(1-0.5.*CD(time).*ratio-2.5.*ratio.^2);
    %correction using Roshko
end

%The value of the CD corrected, incorrected, CD_eqn.


Cp_theoretical=1-4.*(sin(theta_a*pi/180)).^2;
        
plot(theta_a,Cp(:,1),'kx-');
hold on
plot(theta_a,Cp(:,2),'bx-');
hold on
plot(theta_a,Cp(:,3),'rx-');
hold on
plot(theta_a,Cp(:,4),'gx-');
hold on
plot(theta_a,Cp_theoretical,'k-o');
legend('case1','case2','case3(tripwired)','case4(tripwired)','Theoretical');
title('First diagram');
xlabel('Angle');
ylabel('Pressure Coefficient');

hold off

plot(theta_a,Cp(:,1),'k-');
hold on
plot(theta_a,Cp(:,2),'b-');
hold on
plot(theta_a,Cp(:,3),'r-');
hold on
plot(theta_a,Cp(:,4),'g-');
hold on
plot(theta_a,Cp_corrected(:,1),'*k--');
hold on
plot(theta_a,Cp_corrected(:,2),'*b--');
hold on
plot(theta_a,Cp_corrected(:,3),'*r--');
hold on
plot(theta_a,Cp_corrected(:,4),'*g--');
legend('Uncorrected1','Uncorrected2','Uncorrected3(tripwired)','Uncorrected4(tripwired)','Corrected1','corrected2','corrected3(tripwired)','corrected4(tripwired)');
title('Second diagram');
xlabel('Angle/бу');
ylabel('Pressure Coefficient');

hold off
    
    
    
    

    