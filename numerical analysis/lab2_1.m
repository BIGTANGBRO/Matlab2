clear
clc

x1 = 1;
x2 = 0;

while abs(x1-x2)/2 > 0.00002
x3 = (x1+x2)/2;
if fx(x3)*fx(x1) < 0
    x2 = x3;
else
    x1 = x3;
end
end
disp(x1);


function y = fx(x)
    y = x^3 + 2*x -1;
end



