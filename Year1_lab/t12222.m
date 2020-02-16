clear
clc
n=input('input the height of the tree');
stars(1:2*n-1)='*';
for k=1:inf
    clc
    for i=1:n
        if ((i>1)|(mod(k,2)))
            fprintf('%s*\n',n+i-1,stars(1:2*i-1));
        else
            fprintf('\n');
        end
    end
    fprintf('%*s\n',n+1,'/|\');
    pause(0.5)
end