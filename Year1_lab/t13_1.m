clc
clear
fid1=fopen('grades.dat','r');
num=fscanf(fid1,'%d',1);

for j=1:29
    for i=1:13
        data(j,i)={fscanf(fid1,'%s',1)};
    end
end
fclose(fid1);

for i=1:28
    structure(i).name=data(i+1,1);
    structure(i).surname=data(i+1,2);
    structure(i).alias=data(i+1,3);
    structure(i).grades=data(i+1,[4:13]);
end
for j=1:28
    Student(j).grades=str2double(structure(j).grades);
end

classes=data(1,4:13);
mkdir marks_3
cd marks_3

for k =1:28
    fname=[char(structure(k).alias),'-report.txt'];
    fid=fopen(fname,'w');
    fprintf(fid,'Student report card: %s \n',date);
    fprintf(fid,'Student name: %s %s \n\n',char(structure(k).name),char(structure(k).surname));
    fprintf(fid,'Grades \t\t Subject \n');
    for j=1:10
        fprintf(fid,'%3s \t\t %s \n',char(structure(k).grades(j)),char(classes(j)));
    end
    fprintf(fid,'Average: \t  %5.2f \n',mean(Student(k).grades));
    fclose(fid);
end
