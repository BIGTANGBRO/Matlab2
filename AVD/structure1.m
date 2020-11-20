%% structure lab

shearModulus = 28e9;%pa
Vin = 15;%v
Gain = 1000;%gain
s = 2.09;
load = input("Input the voltage when loading");
unload = input("Input the voltage when unloading");
Vout = load - unload;
q = input("input the shear flow");

%calculate the shear strain

