%plot nyquist diagram

num = [2 5 1];
den = [1 2 3];
sys = tf(num,den);
sys

figure(1)
nyquist(sys);
figure(2)
rlocus(sys);
figure(3)
bode(sys);