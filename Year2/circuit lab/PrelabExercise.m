clear
clc

k1 = -0.5929;
k2 = -1.6305;
T=8.2;
wd = 2*pi/T;
load('response.mat');
qt = output_pitch_rate_q(2);
qtT = output_pitch_rate_q(2+82);
AItem = (log((k1-qt)/(k1-qtT))).^2./(4.*pi.^2);
dampRatio = sqrt(AItem./(1+AItem));
wn = wd/(sqrt(1-dampRatio^2));

plot(time, output_pitch_rate_q,'r');

SteadyStateError = 0.188;

n1 = k2
n2 = k1.*wn.^2
d1 = 1
d2 = 2.*dampRatio*wn
d3 = wn.^2
hold on
s=tf('s');
sys = (n1*s + n2)/(d1*s^2+d2*s+d3);
step(sys);
axis([0 60 -1.4 0]);
legend('Original','New model');
hold off
