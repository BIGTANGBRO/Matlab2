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
D=16.36;
R0=1.55;
Croot=0.53;
Ctip=0.53;
E=-18;%degree linear blade twist
angular_velocity=27;%rads s^-1
ic=input('input the blade setting angle');
Vinf=input('input the forward airspeed');
Winf=input('input the rate of descent');
density=1.12;
cut=200;
for i=1:200
    section_chord(i)=Croot+(Ctip-Croot)*i/200;
    R(i)=R0+(D/2-R0)*i/200;
end
FN=0;
azimuth_angle=0;
for i=1:200
    VT(i)=angular_velocity*R(i)+Vinf*sin(azimuth_angle);
    Ve(i)=(VT(i)^2+W^2)^0.5;
end


