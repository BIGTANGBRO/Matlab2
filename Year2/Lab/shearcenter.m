clear
clc

x1=[0:0.5:2];
y1=[20.1,13.2,3.9,-2.9,-9.6];

x2=[0:0.5:2];
y2=[14.2,5.1,-1.8,-8.5,-15.6];

x3=[0:0.5:2];
y3=[6.2,-1,-7.7,-14.5,-21.3];

plot(x1,y1,'r*');
hold on
plot(x2,y2,'g*');
hold on
plot(x3,y3,'b*');

p1=polyfit(x1,y1,1);
p2=polyfit(x2,y2,1);
p3=polyfit(x3,y3,1);

range=[0:0.01:2];
f1=p1(1).*range+p1(2);
f2=p2(1).*range+p2(2);
f3=p3(1).*range+p3(2);
plot(range,f1,'r');
hold on
plot(range,f2,'g');
hold on
plot(range,f3,'b');
grid on
title('Voltage over W2')
xlabel('W2/N')
ylabel('Voltmeter/mV')
legend('points for W1=15N','points for W1=10N','points for W1=5N','line for W1=15N','line for W1=10N','line for W1=5N');