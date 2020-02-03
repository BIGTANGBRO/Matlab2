clear
clc

num1 = 2.0;
num2 = 0.3;
num3 = 0.25;

bi1 = decTobin(num1,5);
bi2 = decTobin(num2,5);
%bi3 = dec2bin(num3);

function bi = decTobin(innum,N)
count = 0;
intNum = floor(innum);

tempnum = innum - intNum;
record = zeros(1,N);
while(N)
    count = count + 1;
    if (count > N-1)
        N = 0;
    end
    tempnum = tempnum * 2;
    if tempnum > 1
        record(count) = 1;
        tempnum = tempnum - 1;
    else
        record(count) = 0;
    end
    
end
biF = record;
biI = dec2bin(intNum);
bi = [char(biI),'.', char(biF + '0')];
bi = str2num(bi)
end


