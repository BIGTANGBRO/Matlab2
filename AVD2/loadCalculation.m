%code to calculate the load
clear 
clc

n = 300;
width = 26.595/n;
croot = 6;
c = [6:-3/(n-1):3];
b = 53.19/2;
loadFactor = 3.4;
rho = 0.33;
%moment of coefficient
cm0 = 0.07;

