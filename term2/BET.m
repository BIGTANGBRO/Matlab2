clc
clear
fid=fopen('N0012.dat','r');
trash=fscanf(fid,'%*s',3);
for i=1:68
    for j=1:3
        CL_CD_VS_AOA(i,j)=fscanf(fid,'%e',1);
    end
end
N=input('input the number of the blades:');
D=input('input the rotor diameter:');
R0=input('input the blade starting radius:');
Croot=input('input the root chord:');
Ctip=input('input the tip chord length');
E=input('input the twist');

