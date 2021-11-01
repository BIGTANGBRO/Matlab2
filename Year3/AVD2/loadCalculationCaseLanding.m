%% loading case during landing case
clear
clc

halfSpan = (53.19-3.9)/2;
y = linspace(0,halfSpan,300);

loadLG = 65300*9.81/0.25;
yLG = linspace(1.95,2.2,100);

loadEngine = 6030*9.81/1;
yEngine = linspace(7.23,8.23,100);

loadWing0 = 5150*9.81/(halfSpan*pi);
loadWing = loadWing0*sqrt(1-(y/halfSpan).^2);

yFuel = linspace(7.394,17.25,200);
loadFuel = 27800.*9.81./(halfSpan*0.4*pi).*(1-yFuel/halfSpan);

totalLoad = zeros(1,300);
totalLoad(25:28) = totalLoad(25:28)+loadLG;
totalLoad(89:101) = totalLoad(89:101)-loadEngine;
totalLoad(:) = totalLoad(:)-loadWing(:);
yFuel2 = linspace(7.394,17.25,120);
loadFuel2 = 27800.*9.81./(halfSpan*0.4*pi).*(1-yFuel2/halfSpan);
totalLoad(91:210)= totalLoad(91:210)-loadFuel2(1:120);

figure(1)
plot(y,-loadWing,'m');
hold on;
plot(yEngine,-loadEngine,'r.-');
hold on;
plot(yLG,loadLG,'b.-');
hold on;
plot(yFuel,-loadFuel,'g');
hold on;
plot(y,totalLoad,'k');
legend("Own weight","Engine","Landing gear","Fuel","Total load");
ylabel('load(N/m)');
xlabel('Wing span loaction(m)');
grid on
hold off

%%

figure(2)
dx = halfSpan/300;
shearForce = totalLoad.*dx;
for i = 1:300
    shearForce(i) = sum(shearForce(i:300));
end    
plot(y,shearForce);
ylabel("Shear force/N");
xlabel("Wing Span/m");
grid on
hold off

shearForce(301)=0;
for i = 1:300
    dbendMoment(i) = (shearForce(i)+shearForce(i+1))*(dx)/2;
end

for i = 1:300
    bendMoment(i) = sum(dbendMoment(i:300));
end   
figure(3);
plot(y,bendMoment);
grid on;
ylabel("Bending Moment/Nm");
xlabel("WingSpan/m");
hold off;