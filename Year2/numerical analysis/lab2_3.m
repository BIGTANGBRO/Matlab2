clc
clear


xn_1 = 20;
xn = 100;


while abs(fx(xn_1)) > 0.01
    xn1 = xn - fx(xn)*((xn - xn_1)/(fx(xn) - fx(xn_1)));
    xn_1 = xn;
    xn = xn1;
    
end
disp(xn)

xnn_1 = 0;
xnn = 1;
while abs(fx2(xnn)) > 0.01
    xnn1 = xnn - fx(xnn)*((xnn - xnn_1)/(fx2(xnn) - fx(xnn_1)));
    xnn_1 = xnn;
    xnn = xnn1;
    
end
disp(xnn)


function y1 = fx(x)
    y1 = x^4 - 2*x -1;
end


function y2 = fx2(x)
    y2 = 2-sin(2*x) - exp(x);
end