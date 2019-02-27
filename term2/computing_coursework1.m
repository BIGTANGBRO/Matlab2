clc
clear
x=input('Input the array of x:');
xval=input('Input the value of x that you want of interpolate:');
fx=input('Input the value of y:');
polyArray=CubicIn(x,fx);
Y_value=cubicEval(x,polyArray,xval);
disp(Y_value);