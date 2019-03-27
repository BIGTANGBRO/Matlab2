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
azimuth_angle=[0:pi/100:2*pi];

for i=1:200
    section_chord(i)=Croot+(Ctip-Croot)*i/200;%the width for each small pieces
    R(i)=R0+(D/2-R0)*i/200;%Distance from center, value of R
end
FN=0;


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
    for j=1:200
        VT(i,j)=angular_velocity*R(i)+Vinf*sin(azimuth_angle(j));%to calculate tangential velocity
        Ve(i,j)=(VT(i)^2+W^2)^0.5;%to calculate downward velocity;
        deltaA(i,j)=atan(W./VT(i,j));
        ae(i,j)=ic+(R(i)-R0)/(D/2-R0)+deltaA(i,j);%to calculate angle of attack
    end
    
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
    for j=1:200
        CL(i,j)=CubicEval(AOA_list,polyArray_CL,ae(i,j));
        CD(i,j)=CubicEval(AOA_list,polyArray_CD,ae(i,j));%use function created before to find corresponding CD and CL
    end
end

%use trapz function of calculate double integrals

%calculate total thrust of the rotor disc
%fitsr integrate by Radius then by psi
d_Fn=N*(0.5*density*Ve.^2).*section_chord.*(CL.*cos(deltaA)+CD.*sin(deltaA))./(2*pi);
Fn=trapz(azimuth_angle,trapz(R,d_Fn));

d_Fx=N*(0.5*density*Ve.^2).*section_chord.*(CD.*cos(deltaA)+CL.*sin(deltaA)).*sin(azimuth_angle)./(2*pi);
Fx=trapz(azimuth_angle,trapz(R,d_Fx));

d_Fy=-N*(0.5*density*Ve.^2).*section_chord.*(CD.*cos(deltaA)+CL.*sin(deltaA)).*cos(azimuth_angle)./(2*pi);
Fy=trapz(azimuth_angle,trapz(R,d_Fy));

d_T=N*(0.5*density*Ve.^2).*section_chord.*(CD.*cos(deltaA)+CL.*sin(deltaA)).*R./(2*pi);
T=trapz(azimuth_angle,trapz(R,d_Ft));

%calculate diving power
P=T*angular_velocity;

%calculate pitching and rolling moments
d_Mx=-N*(0.5*density*Ve.^2).*section_chord.*(CL.*cos(deltaA)+CD.*sin(deltaA)).*R.*cos(azimuth_angle)./(2*pi);
Mx=trapz(azimuth_angle,trapz(R,d_Mx));

d_My=-N*(0.5*density*Ve.^2).*section_chord.*(CD.*cos(deltaA)+CL.*sin(deltaA)).*R.*sin(azimuth_angle)./(2*pi);
My=trapz(azimuth_angle,trapz(R,d_My));







































