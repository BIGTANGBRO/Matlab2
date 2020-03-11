k1 = -0.59;
k2 = 0.08;
T=5.8;
wd = 2*pi/T;

qt = 0;
qtT = -0.4699;
AItem = (log((k1-qt)/(k1-qtT))).^2./(4.*pi.^2);
dampRatio = sqrt(AItem./(1+AItem));
wn = wd/(sqrt(1-dampRatio^2));
load('response.mat');
plot(time, output_pitch_rate_q);

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
hold off