
clear all
clc
t = 0.1;
n = 1:9;
e = n/10 - n*t;
e;
fprintf('%.20f\t',n/10);
fprintf('%.20f\t',n*t);
fprintf('%.20f\t',e);