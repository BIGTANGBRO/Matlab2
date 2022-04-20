clear 
clc

%%
% basic equation for the resistance calculation


%intitalize values

m_cyclist = 56.5;
t = [0:1:5000];
m_bike = 7;
g = 9.81;
rho = 1.225; %air density
Vg = 10;

k = 0.008; %average slope of the climb
a = rad2deg(atan(k));

%wind speed and direction
Vw = 1; %positive windspeed as in opposing direction
alpha = 10; 
Vw_tan = Vw*cosd(alpha);
Vw_nor = Vw*sind(alpha);

%airspeed of the cyclist and yaw angle
Va = Vg-Vw_tan;
beta = atan(Vw_nor./Va);
Cd = 0.9; %drag coefficient affected by yaw angle (0.5-0.9)
A = 0.6;  %Frontal area as a function of yaw angle (0.2-0.6) 


[Pa,Prr,Ppe,Pke,Po] = calculateEnergy(Vg,rho,Cd,A,m_cyclist,m_bike,a,0);


% loop to iteration power, velocity and acceleration
PInput = 500;
for vNew = Vg:0.01:1000
    if (Po >= PInput)
        break;
    end
    dVg = vNew - Vg;
    [Pa,Prr,Ppe,Pke,Po] = calculateEnergy(vNew,rho,Cd,A,m_cyclist,m_bike,a,dVg);

end

%plot the relation between velocity and the power
%plot(Vg, Po);


%calculate the total energy consumption
W=10e6;
%Visulization of various drags at different velocities
%Visulization of energy consumption
%Visulization of power output phase

function [Pa,Prr,Ppe,Pke,Po] = calculateEnergy(Vg,rho,Cd,A,m_cyclist,m_bike,a,dVg)
    g = 9.81;
    Vw = 1; %positive windspeed as in opposing direction
    alpha = 10; 
    Vw_tan = Vw*cosd(alpha);
    Vw_nor = Vw*sind(alpha);
    Va = Vg-Vw_tan;
    Fw = 0.5; %rotational drag coefficient 
    %%Power calculation
    %Aero drag
    %Translational
    Dt = 0.5.*rho.*(Va.^2).*Cd.*A;
    Pt = Dt.*Vg;
    
    %Rotational
    Fw = 0.5; %rotational drag coefficient 
    Dr = 0.5*rho*Fw*Cd;
    Pr = Dr.*Vg;
    
    Pa = Pt+Pr; %total aero drag
    
    %Rolling resistance
    Crr = 0.01; %rolling resistance coefficient(effected by contact characteristic) 
    Frr = (m_cyclist+m_bike)*g*cosd(a)*Crr;
    Prr = Frr.*Vg;
    
    %potential engergy
    Ppe = (m_cyclist+m_bike).*g.*Vg.*sind(a);
    
    %% kinetic energy
    %Translational
    Pket = 0.5.*(m_cyclist+m_bike).*(dVg.^2);
    %Rotational
    domega = dVg./0.32; %angular velocity of the wheel
    If = 0.034; %moment of inertia of the front wheel calculated from estimated typial front wheel profile for a 50mm depth rim
    Ir = 0.036; %moment of inertia of the rear wheel calculated from estimated typial rear wheel profile for a 50mm depth rim
    Pker = 0.5*(If+Ir)*domega.^2;
    Pke = Pket+Pker;
    % power output modification
    
    % estimate power required for a given time
    Po = Pa + Prr + Ppe + Pke;
end
