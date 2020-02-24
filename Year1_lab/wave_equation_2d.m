clear
clc
nsteps=2100;
c1=0.1;
c2=1.0;
dt=0.2;
w=2.5;
nx=200;
ny=100;
cx=15;
cy=10;
a=zeros(nx,ny);
v=zeros(nx,ny);
for i=1:nx
    for j=1:ny
        r=((i-nx/2-cx)^2+(j-ny/2-cy)^2)^0.5;
        z(i,j)=2*exp((-r/w)^2)-exp(-(r/(2*w))^2);
    end
end
for step=0:nsteps
    for i=2:nx-1
        for j=2:ny-1
            z(i,j)=z(i,j)+v(i,j)*dt;
        end
    end
    
    for i=2:nx-1
        for i=2:ny-1
            a(i,j)=(c2/c1)*(z(i-1,j)-2*z(i,j)+z(i+1,j))+(c2/c1)*(z(i,j-1)-2*z(i,j)+z(i,j+1));
        end
    end
    for i=2:nx-1
        for j=2:ny-1
            v(i,j)=v(i,j)+a(i,j)*dt;
        end
    end
    if (mod(step,2)==0)
        imagesc(z);axis([1 ny 1 nx])
        pause(0.001);
        if(step==0);pause();
        end
    end
end
