clc
clear all

fid1=fopen('input.dat','r');
vals=fscanf(fid1,'%d',[1,3]);
A=fscanf(fid1,'%f',[2]);
X=A(1,:);
Y=A(2,:);
disp(vals);
msg=fscanf(fid1,'%s');
disp(msg);
fid2=fopen('tp_data.dat','r');
title=fscanf(fid2,'%s %s',[1,2]);
meaP=fscanf(fid2,'%f',[2,inf]);
disp(meaP');
meaP1=meaP';
P=meaP1(:,1);
T=meaP1(:,2);
density=(1000*P./T)./287.04;
fid3=fopen('tp_res.dat','w');
fprintf(fid3,'%s  \n','Temperature  Pressure  Density');
for i =1:length(P)
    fprintf(fid3,'%1$3.1f        %2$7.1f      %3$6.4f\n',P(i),T(i),density(i));
end
