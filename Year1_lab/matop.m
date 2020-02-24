x=[0:0.1:10];
y=[0:0.05:5];
u=y+sin(x);
v=cos(x+y);
[x,y]=meshgrid(u,v);
streamslice(x,y);