%housekeeping
clear
clc
%open source file
fid=fopen('grades.dat','r');
%read number of students from first line
CHAPTER 13. ADVANCED MATLAB 2 9
n=fscanf(fid,'%d \n',1);
fscanf(fid,'%*s',3); %skip next 3 strings
%use loop to read class names into cell array
for i=1:10
classes(i)={fscanf(fid,'%s',1)};
end
%read the marks table row by row
for i=1:n
record(i).name=fscanf(fid,'%s',1);
record(i).surname=fscanf(fid,'%s',1);
record(i).alias=fscanf(fid,'%s',1);
record(i).grades=fscanf(fid,'%d',10); %read into 10x1 array
end
fclose(fid); %close file
%create folder for marks and change directory
mkdir marks
cd marks
for i=1:n
%create filename based on student alias
fname=[record(i).alias,'-report.txt'];
%open file and give overwrite permission
fid=fopen(fname,'w');
%report title and creation date
fprintf(fid,'\t\t STUDENT REPORT CARD: %s \n\n',date);
%student name
fprintf(fid,'Student: %s %s \n\n',record(i).name,record(i).surname);
%create header for results
fprintf(fid,'Grade \t\t Subject \n');
%print marks and course names
for j=1:10
fprintf(fid,'%3d \t\t %s \n',record(i).grades(j),char(classes(j)));
end
%calculate and print mean
fprintf(fid,'\n%5.2f \t\t Average\n',mean(record(i).grades));
fclose(fid); %close file
end
%move back to original directory
cd ..
%end of script