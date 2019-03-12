clear 
clc
step=0.5;
x=step:step:10-step;
y=step:step:5-step;

[x,y]=meshgrid(x,y);
u=y+sin(x);
v=cos(x+y);
figure;
quiver(x,y,u,v);
xlabel('x');
ylabel('y');
figure(2)
streamslice(x,y,u,v)
xlabel('x')
ylabel('y')