load('response.mat');
q = output_pitch_rate_q;

T=8.2;

freq = 2*pi/T;
K1 = q(length(q));
c = log((K1-q(2))/(K1-q(2+82)));
DR = sqrt(c^2/(4*pi^2+c^2));
nFreq=freq/sqrt(1-DR^2);
K2=1.65;
G = @(s) (K1*nFreq^2+K2*s)/(s.^2+2*DR*nFreq*s+nFreq^2);
sim('prelab.slx',20);

Time = (0:0.5:20);
plot(Time,K1*ones(1,41));
hold on 
plot(time,q);
