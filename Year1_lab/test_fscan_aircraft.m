clear
clc
fid=fopen('ACdata.txt','r');
trash=fscanf(fid,'%*s',23);
for i=1:6
    for j=1:7
        data(i,j)={fscanf(fid,'%s',1)};
    end
end
fclose(fid);
for i =1:6
    structure(i).name=cell2mat((data(i,1:2)));
    structure(i).number_of_engines=str2num(cell2mat(data(i,3)));
    structure(i).engine_type=char(data(i,4));
    structure(i).seats=str2num(cell2mat(data(i,5)));
    structure(i).cruise_speed=str2num(cell2mat(data(i,6)));
    structure(i).max_take_off_weight=str2num(cell2mat(data(i,7)));
end
