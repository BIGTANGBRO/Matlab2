%Initial Weight Sizing

clear
clc

%initialize Vmin
Vmin = 200;

w1w0 = 0.92;
w2w1 = 0.980;
w3w2 = exp(-8500*10^3*0.0001389/(0.8*340*16*0.866));
w4w3 = 0.990;
w5w4 = 0.980;
w6w5 = exp(-370*10^3*0.0001389./(Vmin*16*0.866));
w7w6 = exp(-45*60*0.0001111/16);
w8w7 = 0.980;
w9w8 = 0.992;
w9w0 = w1w0*w2w1*w3w2*w4w3*w5w4*w6w5*w7w6*w8w7*w9w8;
wfw0 = 1.01*(1-w9w0);

g=9.81;
A=0.97;
c=-0.06;

Wc=(2+6)*80; %Weight of flight crew(2 Pilots/6 Cabin Attendants)
Wp=250*80;  %Weight of 250 passengers
Wb=(2+6+250)*40; %Weight of baggages

W=1e5:208.2:3.5e5;%Initial Guess of W0
WfW0=1.01*(1-w9w0); %Fuel fraction


for i=1:length(W)
    WeW0(i)=0.95*A*(W(i)^c); %Empty weight fraction
end


for j= 1:1201
     W0(j)=(Wc+Wp+Wb)/(1-(WfW0)-(WeW0(j))); %Gross take-off weight
end

% Y=linspace(1,1.992e5,100);
% X=ones(1,100);
% X=X.*1.992e5;


plot(W,W,'LineWidth',1.5)
hold on
plot(W,W0,'LineWidth',1.5)
% plot(1.992e5,1.992e5,'ks')
% plot(X,Y,':k','LineWidth',1.5)
% text(2.1e5,2.05e5,'1.992\times10^{5}','FontSize',12)
grid minor
xlabel('W_0/kg')
ylabel('W_0/kg')
leg=legend('$W_0$','$\frac{W_{crew}+W_{payload}}{1-(\frac{W_f}{W_0})-(\frac{W_e}{W_0})}$','Location','Northwest');
set(leg,'interpreter', 'latex','FontSize',12)
hold off

%find the intersection
for i=1:1201
    if W(i) - W0(i) <= 0.001
           Wselect = W(i); 
    end
end

%Minimum Drag Velocity
rho=1.225;
Sref=120;
Cd0=0.023;
AR=9.4;
k=1/0.8; %Oswald factor
Wcr=0.6433*g*Wselect; %Weight of cruise
A1=0.5*rho*Sref*Cd0;
B=(k*Wcr.^2)/(0.5*pi*AR*rho*Sref);
Vmin2=(B./A1).^0.25; %Indicated air speed

fprintf("The weight is %5.3f kg\n", Wselect);
fprintf("The first Vimd is %5.3f m/s\n", Vmin);
fprintf("The second Vimd is %5.3f m/s\n", Vmin2);


