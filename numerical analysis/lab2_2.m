clear
clc

x0 = 3;
while abs(fx(x0)) > 0.001
    x1 = x0 - fx(x0)/dfx(x0);
    x0 = x1;
end
disp(x1);
 
function y = fx(x)
   y = x^3 + 2*x -1;
end

function xF = dfx(x)
    xF = 3*x^2 + 2;
end