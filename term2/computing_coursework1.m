clc
clear
x=input('Input the array of x:');
fx=input('Input the value of y:');
xval=input('Input the value of x that you want of interpolate:');
polyArray=CubicIn(x,fx);
Y_value=cubicEval(x,polyArray,xval);
disp(Y_value);