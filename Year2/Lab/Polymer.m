%%
clear
clc
kmean = calKmean;

a=[0.001,0.002,0.003,0.004,0.005,0.006,0.007,0.008];
c=[1.5e-6,1.9e-6,2.4e-6,2.6e-6,3.73e-6,5.9e-6,1.16e-5,3.98e-5];
scatter(a,c,'b*');
hold on 
range=linspace(0,0.008,100);
fit = 1.144e-06.*exp(175.6.*range)+7.003e-10.*exp(1352.*range);
plot(range,fit,'b')
title('Compliance C over Crack length a')
xlabel('Crack length a(m)')
ylabel('Compliance d/F(mN^-1)')


F=[91.8949,83.9691,109.658,86.6504,87.3715];
dcda=[0.0014,0.0014,0.0014,0.0014,0.0015];
B=[4.78,4.91,4.8,5.07,5.05];
Gic=dcda.*F.^2./(2.*B);
Avg = sum(Gic)/5

function kmean = calKmean()
Test1 = [4.78,9.91,4.95,40];
Test2 = [4.91,9.93,5.05,40];
Test3 = [4.80,9.98,5.00,40];
Test4 = [5.07,9.95,5.05,40];
Test5 = [5.05,10.00,5.18,40];

a_w=[5.08/10.03,5.05/10.05,4.85/10,4.92/10,5.11/10.011];
F=[91.8949,83.9691,109.658,86.6504,87.3715];
Y=[1.48,1.463,1.41,1.43,1.495];
K1 = Y(1)*3*F(1)*Test1(4)/(2*Test1(1)*Test1(2)^2)*sqrt(pi*Test1(3))*1000^1.5/1000000
K2 = Y(2)*3*F(2)*Test2(4)/(2*Test2(1)*Test2(2)^2)*sqrt(pi*Test2(3))*1000^1.5/1000000
K3 = Y(3)*3*F(3)*Test3(4)/(2*Test3(1)*Test3(2)^2)*sqrt(pi*Test3(3))*1000^1.5/1000000
K4 = Y(4)*3*F(4)*Test4(4)/(2*Test4(1)*Test4(2)^2)*sqrt(pi*Test4(3))*1000^1.5/1000000
K5 = Y(5)*3*F(5)*Test5(4)/(2*Test5(1)*Test5(2)^2)*sqrt(pi*Test5(3))*1000^1.5/1000000

kmean = (K1+K2+K3+K4+K5)/5;
end