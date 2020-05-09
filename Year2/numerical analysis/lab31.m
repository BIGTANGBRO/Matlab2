%%Lab 3
clear
clc
%%

x = [0.2:0.5:2.2];
fxdx = 0;
n=length(x)-1;
h=2/n;


for i = 0:n
    if mod(i,2) == 0
        if (i == 0)|| (i == n)
            fxdx = fxdx + fx(x(i+1));
        else
            fxdx = fxdx + 2*fx(x(i+1));
        end
    else
        fxdx = fxdx + 4*fx(x(i+1));
    end
end

fxdx = h/3*fxdx;
disp(fxdx);

    
function y = fx(x)
y = x*exp(x);
end

%%end of the file
