clc
clear
fid=fopen('N0012.dat','r');
trash=fscanf(fid,'%*s',3);
for i=1:68
    for j=1:3
        AOA_VS_CL_CD(i,j)=fscanf(fid,'%e',1);
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
    section_chord(i)=Croot+(Ctip-Croot)*i/200;%the width for each small pieces
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
    Ve(i)=(VT(i)^2+W^2)^0.5;%to calculate downward velocity;
    deltaA=atan(W/VT(i));
    ae(i)=ic+(R(i)-R0)/(D/2-R0)+deltaA;%to calculate angle of attack
end

% use cubic spline to calculate corresponding value of CL and CD specific
% angle of attack
CL=[];%initiate lift coefficient
CD=[];%initiate dray coefficient
AOA_list=AOA_VS_CL_CD(:,1);
CL_list=AOA_VS_CL_CD(:,2);
CD_list=AOA_VS_CL_CD(:,3);
polyArray_CL=CubicIn(AOA_list,CL_list);
polyArray_CD=CubicIn(AOA_list,CD_list);
%still need to use nested loop to calculate CL and CD for different
%azimuth_angle.
for i=1:200
    CL(i)=CubicEval(AOA_list,polyArray_CL,ae(i));
    CD(i)=CubicEval(AOA_list,polyArray_CD,ae(i));
end



    





