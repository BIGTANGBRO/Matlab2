clear
clc

N_number=300;
bf = (53.19-3.9)/2;
bs=bf/cos(0.5542);
dx = bs/(N_number-1);
x = 0 : dx : bs;

load('N.mat')
%choice of 3
l=0;
c=3.85839;
N=NormalLoad(1);
k=0;
ratio=0.55;
n=35;
b_box=1;
D=1;
b=c/(n+1);
c_box=3.85839;
F=0.7;
E=76*10^(9);

while l < bs
    k=k+1;
    t=((N/(3.62*E))*(b^2))^(1/3);
    sigma_0=(N/t);
    sigma_cr=sigma_0*ratio;
    L(k)=((F/sigma_cr)^2)*N*E;
    l=l+L(k);
    t_r(k)=sqrt(N*(L(k)^3)/((4*(F^2)*(D^2)*E)));
    N=interp1(x,NormalLoad,l,'pchip');
    t_r(k)=sqrt(N.*(L(k)^3)/((4*(F^2)*(D^2)*E)));

end

