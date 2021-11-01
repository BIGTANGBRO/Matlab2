%plot nyquist diagram
clear
clc

s=tf('s');
sys=(1)/(s+1)^2;
% sys = tf(num,den);

figure(1)
nyquist(sys);
figure(2)
rlocus(sys);
% figure(3)
% bode(sys);
