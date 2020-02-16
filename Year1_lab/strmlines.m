x=[0:1:10];
y=[0:0.5:5];
for i =1:11
    u(i)=y(i)+sin(x(i));
    v(i)=cos(x(i)+y(i));
end
quiver(u,v);
        