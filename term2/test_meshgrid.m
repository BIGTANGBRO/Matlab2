x=[-10:0.1:10];
y=x;
[x,y]=meshgrid(x,y);
z=tan((x.^2+y.^2).^0.5)./(x.^2+y.^2).^0.5;
surf(x,y,z);
