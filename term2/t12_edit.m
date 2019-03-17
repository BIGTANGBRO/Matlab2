clear
clc

n=input('input the height of the tree:');
stars(1:2*n-1)='*';
while(1)
    clc
    pause(0.2);
    for i=1:n
        fprintf('%2$*1$s\n',n+i-1,stars(1:2*i-1));
    end
    fprintf('%*s\n',n+1,'/|\');
    pause(0.2)
end
