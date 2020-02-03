%%Lab 3
clear
clc
%%

x = [-1:0.1:1];
fxdx = 0;
n=length(x)-1;
h=2/n;
a=1;
b=2;
c=3;

for i = 0:n
    if mod(i,2) == 0
        if (i == 0)|| (i == n)
            fxdx = fxdx + fx(x(i+1),a,b,c);
        else
            fxdx = fxdx + 2*fx(x(i+1),a,b,c);
        end
    else
        fxdx = fxdx + 4*fx(x(i+1),a,b,c);
    end
end

fxdx = h/3*fxdx;
disp(fxdx);

    
function y = fx(x, a, b, c)
y = a*x^5 + b*x^2 + c*x;
end

%%end of the file
