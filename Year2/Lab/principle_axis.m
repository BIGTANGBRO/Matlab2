clear
clc

Wx_Wy = [0:0.05:0.6];
DxDy = [-1.6034,-1.5254,-1.2951,-1.2069,-1.1458,-0.9167,-0.6667,-0.4615,-0.2647,-0.13333,0.76,1.28571,2.5];

Wx_Wy2 = [0:0.1:0.6];
DxDy2 = [-1.375,-1.0313,-0.8571,-0.52,0,1,1.8333];

scatter(Wx_Wy,DxDy,'g*');
hold on
scatter(Wx_Wy2,DxDy2,'b*');

p1 = polyfit(Wx_Wy,DxDy,3);
p2 = polyfit(Wx_Wy2,DxDy2,3);
range = linspace(0,0.6,100);

y1= p1(1).*range.^3 +p1(2).*range.^2 +p1(3).*range + p1(4);
y2= p2(1).*range.^3 +p2(2).*range.^2 +p2(3).*range + p2(4);
hold on
plot(range,y1,'g');
hold on
plot(range,y2,'b');
hold on
plot(range,range,'k');
grid on
title('Dx/Dy over Wx/Wy')
xlabel('Wx/Wy');
ylabel('Dx/Dy');
legend('points when Wy=10N','points when Wy=5N','line for Wy=10N','line for Wy=5N','Linear');