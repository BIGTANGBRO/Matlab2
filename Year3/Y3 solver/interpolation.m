%interpolation
clear
clc

upper = input("Input the upper");
lower = input("Input the lower");

upVal = input("First val");
lowVal = input("Second val");

intVal = input("Input the value needs interpolates");

gradient = (upVal-lowVal)/(upper-lower);
b = upVal-gradient*upper;

finalVal = gradient * intVal + b
