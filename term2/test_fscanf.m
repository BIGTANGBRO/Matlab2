clear
clc
fid=fopen('grades.dat','r');
t1=fscanf(fid,'%d',1);
t2=fscanf(fid,'%s',13);
data=[];
for i=1:28
    for j=1:13
        data(i,j)={fscanf(fid,'%s',1)};
    end
end
