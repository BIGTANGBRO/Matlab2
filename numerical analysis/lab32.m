%% lab32
clc
clear

eta = etas(4);
weight = weights(4);
sum=0;

for i = 1:4
    sum = sum + eta(i)*fx(weight(i));
end

disp(sum)


function y = fx(x)
    y = exp(-x^2);
end

%%