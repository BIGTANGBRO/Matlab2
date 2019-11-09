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


V(1)=19.3;
V(2)=30.1;
V(3)=19.8;
V(4)=30.05;
g=9.81;
rho=789;  
p1=D1(:,3).*g.*rho.*0.0254;
p2=D2(:,3).*g.*rho.*0.0254;
p3=D3(:,3).*g.*rho.*0.0254;
p4=D4(:,3).*g.*rho.*0.0254;
angle_measure=D1(:,2);
pressure=[p1,p2,p3,p4];
pa=98730;
for time=1:4
    Re=1.225*V(time)*0.00102/(1.79*10^(-5));
    Cp_measure(:,time)=(98730-pressure(:,time))./(0.5*1.225*V(time).^2);
    
   
    for angle=0:1:180
        Cp(angle+1,time)=interp1(angle_measure(2:28),Cp_measure(2:28,time),angle,'spline');
    end
    
    CD(:,time)=trapz(0:pi/180:pi,Cp(1:181,time).*cos(0:pi/180:pi));
    
    %wall interference correction
    ratio=0.102/0.46;
    V_corrected(:,time)=V(time).*(1+0.25.*CD(:,time).*ratio+0.82.*ratio^2);
    CD_corrected(:,time)=CD(:,time).*(1-0.5.*CD(:,time).*ratio-2.5.*ratio^2);
end

for time2=1:4
    Cp_corrected(1:181,time2)=1+((V_corrected(:,time2)./V(time2)).^2).*(Cp(:,time2)-1);
    CD_eqn(1:181,time2)=trapz(0:pi/180:pi,Cp_corrected(1:181,time2).*cos(0:pi/180:pi));
end

theta=0:1:180;
Cp_theoretical=1-4.*(sin(theta.*pi./180)).^2;
        
plot(theta,Cp(:,1),'k-');
hold on
plot(theta,Cp(:,2),'k:');
hold on
plot(theta,Cp(:,3),'k--');
hold on
plot(theta,Cp(:,4),'k-.');
hold on
plot(theta,Cp_theoretical,'-k<')

%plot(theta,Cp(1,:),'k-');
%hold on
%plot(theta,Cp(2,:),'k:');
%hold on
%plot(theta,Cp(3,:),'k--');
%hold on
%plot(theta,Cp(4,:),'k-.');
%hold on
%plot(theta,Cp_corrected(1,:),'-k.');
%hold on
%plot(theta,Cp_corrected(2,:),':k*');
%hold on
%plot(theta,Cp_corrected(3,:),'--k>');
%hold on
%plot(theta,Cp_corrected(4,:),'-.ko');

    
    
    
    

    