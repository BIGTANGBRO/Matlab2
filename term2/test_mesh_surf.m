
x=[-10:0.1:10];
y=x;
[X,Y]=meshgrid(x,y);
for i=1:length(x)
    for j=1:length(y)
    Z(i,j)=cos(sqrt(X(i,j)^2+Y(i,j)^2))/sqrt(X(i,j)^2+Y(i,j)^2);
    end
end

surf(X,Y,Z)