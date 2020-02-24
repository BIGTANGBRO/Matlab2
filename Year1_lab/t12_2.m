clear
clc


height=input('input the height of the tree:');

fid=fopen('a.txt','w');
maxv=1+2*(height);
Blank=(maxv-1)/2;
while (1)
    clc
    pause(0.5)
    fprintf(fid,'%1$*2$s \n','*',Blank);
    for j =1:(height-1)%level
        k=1+(j)*2;%k=number of stars in that row
        fprintf(fid,'%1$*2$s','*',(Blank-j));
        for i=1:(k-1)
            fprintf(fid,'%s','*');
        end
    
        fprintf(fid,'\n');
    end
    fprintf(fid,'%1$*2$s \n','/|\',(Blank+1));
    pause(0.5);
end
fclose(fid)
    