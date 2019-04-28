%the script that will use two functions to calculate corresponding value
clc
clear
%ask users for the input
x=input('Input the array of x:');
fx=input('Input the value of y:');
xval=input('Input the value of x that you want of interpolate:');
if length(xval)>1
    disp('The input of xval should be a scalar')
elseif length(x)~=length(fx)%prevent wrong inputs
    disp('The coordiantes have different dimensions')
else
    polyArray=CubicIn(x,fx);%get the coefficients from function CubicIn
    %xval must be a scalar
    Y_value=cubicEval(x,polyArray,xval);
    %one output each time
    disp(Y_value);
end
