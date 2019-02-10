clc
clear
fid1=fopen('grades.dat','r');
num=fscanf(fid1,'%d',1);
for j=1:28
    for i=1:13
        data(j,i)={fscanf(fid1,'%s',1)};
    end
end
structure.name=data([2:28],1);
structure.surname=data([2:28],2);
structure.alias=data([2:28],3);
structure.grades=data([2:28],[4:13]);
classes={'MathsI',data(2:28,4),'MathsII',data(2:28,5),'PhysicsI',data(2:28,6),'PhysicsII',data(2:28,7),'Chemistry',data(2:28,8),'Econometrics',data(2:28,9),'EnglishLit',data(2:28,10),'Ancient_Greek',data(2:28,11),'PhysED',data(2:28,12),'Tok',data(2:28,13)};
for k =1:27
    k=fopen('alias(k).txt','w');
    fprintf(k,'%1s   %2s     %3$4.1f',structure.name(i),structure.surname(i),structure.grades(i,:));
end
