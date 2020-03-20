clear
clc
n=0;
for R=5:5:10
    n=n+1;
    A=[170,30,-60;-1,1,0;-50,-10,71+R];
    B=[0;23.1;0];
    I=inv(A)*B;
    i(n)=I(3);
end

b=[5*i(1);10*i(2)];
r=[1,-i(1);1,-i(2)];
ans=inv(r)*b;
V_t=ans(1)
R_t=ans(2)


