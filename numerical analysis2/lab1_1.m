clear
clc

%%
lam=-1;
finalTime=25;
y0=1;

h=input('input the number');

yNum(1)=y0;
tNum=1:h:finalTime;

for i = 1:length(tNum)-1
    ydot=lam.*yNum(i);
    yNum(i+1)=yNum(i)+h.*ydot;
    tNum(i+1)=tNum(i)+h;
end
N1=i+1;
figure(1);
hold on 
box on
grid on
plot(tNum,yNum,'ro--');

y_sol=@(t) y0*exp(lam*t);
N=500;
tExact=linspace(0,finalTime,N);
yExact=y_sol(tExact);
plot(tExact,yExact,'ok');



