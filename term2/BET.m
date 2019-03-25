clc
clear
fid=fopen('N0012.dat','r');
trash=fscanf(fid,'%*s',3);
for i=1:68
    for j=1:3
        CL_CD_VS_AOA(i,j)=fscanf(fid,'%e',1);
    end
end
N=4;%blade numbers
D=16.36;%diameter of the blade
R0=1.55;
Croot=0.53;
Ctip=0.53;
E=-18;%degree linear blade twist
angular_velocity=27;%rads s^-1
ic=input('input the blade setting angle');%get the blade setting angle
Vinf=input('input the forward airspeed');%forwad speed
Winf=input('input the rate of descent');
twist=input('input the twist of the blade');
density=1.12;
cut=200;
for i=1:200
    Clocal(i)=Croot+(Ctip-Croot)*i/200;%the width for each small pieces(local chord length)
    R(i)=R0+(D/2-R0)*i/200;%Distance from center, value of R
end
FN=0;
azimuth_angle=0;

%calculate the velocity normal to disc W
%need condition to do calculation
if Winf<=0
    W=Winf/2-1/2*sqrt(Winf^2+8*FN/(pi*density*D^2));
elseif Winf >sqrt(8*FN/(density*pi*D^2))
    W=Winf/2+1/2*sqrt(Winf^2-8*FN/(pi*density*D^2));
else
    disp('No analytical solution.');
end

for i=1:200
    VT(i)=angular_velocity*R(i)+Vinf*sin(azimuth_angle);%to calculate tangential velocity
    Ve(i)=(VT(i)^2+W^2)^0.5;%to calculate downward velocity;(local airspeed)
    deltaA=atan(W/VT(i));%change of angle
    ae(i)=ic+(R(i)-R0)/(D/2-R0)+deltaA;%to calculate angle of attack
end
%use cubic spline to find Cl and Cd




