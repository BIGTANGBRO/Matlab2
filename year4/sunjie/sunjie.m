 clear
clc

L1 = [0:0.1:65].*10^-3;
L2 = [65:0.1:129].*10^-3;
L3 = [129:0.1:194].*10^-3;
F1 = 8.3;

%M1 = - F1.* L1;
M2 = F1 * 65.*10^-3;
%M3 = -F1.*(194 - L3);

b = [15:0.1:50].*10^-3;
h = [0.06:0.06:1.8].*10^-3;

%select the b
I = (1./12).*h.^3.*b(349);
y = h./2;

%calculate the young modulus
c1 = cos(deg2rad(2.5));
c2 = cos(deg2rad(-2.5));
c3 = cos(deg2rad(-2.5));
c4 = cos(deg2rad(2.5));

s1 = sin(deg2rad(2.5));
s2 = sin(deg2rad(-2.5));
s3 = sin(deg2rad(-2.5));
s4 = sin(deg2rad(2.5));

Tsig1 = [c1.^2, s1.^2,2*c1*s1;s1.^2, c1.^2,-2*c1*s1;-c1*s1,c1*s1,(c1^2-s1^2)];
Tsig2 = [c2.^2, s2.^2,2*c2*s2;s2.^2, c2.^2,-2*c2*s2;-c2*s2,c2*s2,(c2^2-s2^2)];
Tsig3 = [c3.^2, s3.^2,2*c3*s3;s3.^2, c3.^2,-2*c3*s3;-c3*s3,c3*s3,(c3^2-s3^2)];
Tsig4 = [c4.^2, s4.^2,2*c4*s4;s4.^2, c4.^2,-2*c4*s4;-c4*s4,c4*s4,(c4^2-s4^2)];

Tstr1 = [c1.^2, s1.^2,c1*s1;s1.^2, c1.^2,-c1*s1;-2*c1*s1,2*c1*s1,(c1^2-s1^2)];
Tstr2 = [c2.^2, s2.^2,c2*s2;s2.^2, c2.^2,-c2*s2;-2*c2*s2,2*c2*s2,(c2^2-s2^2)];
Tstr3 = [c3.^2, s3.^2,c3*s3;s3.^2, c3.^2,-c3*s3;-2*c3*s3,2*c3*s3,(c3^2-s3^2)];
Tstr4 = [c4.^2, s4.^2,c4*s4;s4.^2, c4.^2,-c4*s4;-2*c4*s4,2*c4*s4,(c4^2-s4^2)];

%global young's modulus
v1 = 0.26;
v2 = 0.26;
E1 = 153000e6;
E2 = 9500e6;
G12 = 3160e6;
Q = [E1/(1-v1*v2), v2*E1/(1-v1*v2),0;v1*E2/(1-v1*v2),E2/(1-v1*v2),0;0,0,G12];
%Stiffness matrix
Qbar1 = Tsig1^(-1)*Q*Tstr1;
Qbar2 = Tsig2^(-1)*Q*Tstr2;
Qbar3 = Tsig3^(-1)*Q*Tstr3;
Qbar4 = Tsig4^(-1)*Q*Tstr4;

%global stress
sig = [1800e6;160e6;60e6];
sigGlobal1 = Tsig1^(-1) * sig;
sigGlobal2 = Tsig2^(-1) * sig;
sigGlobal3 = Tsig3^(-1) * sig;
sigGlobal4 = Tsig4^(-1) * sig;

%initialize A matrix
%initialize B matrix
%initialize D matrix
A = [];
B = [0,0,0;0,0,0;0,0,0];
D = [];
z = [0.03:-0.015:-0.03];
t = 0.015;
for i = 1:3
    for j = 1:3
        A(i,j) = Qbar1(i,j)*t + Qbar2(i,j)*t +Qbar3(i,j)*t +Qbar4(i,j)*t;
        D(i,j) = 1/3*Qbar1(i,j)*(z(1)^3-z(2)^3) + 1/3*Qbar2(i,j)*(z(2)^3-z(3)^3)+1/3*Qbar3(i,j)*(z(3)^3-z(4)^3)+1/3*Qbar4(i,j)*(z(4)^3-z(5)^3);
    end
end

sigmaVonMises1 = sqrt(0.5*((sigGlobal1(1) - sigGlobal1(2))^2 + sigGlobal1(1)^2 + sigGlobal1(2)^2+6*sigGlobal1(3)^2));
sigmaVonMises2 = sqrt(0.5*((sigGlobal2(1) - sigGlobal2(2))^2 + sigGlobal2(1)^2 + sigGlobal2(2)^2+6*sigGlobal2(3)^2));
sigmaVonMises3 = sqrt(0.5*((sigGlobal3(1) - sigGlobal3(2))^2 + sigGlobal3(1)^2 + sigGlobal3(2)^2+6*sigGlobal3(3)^2));
sigmaVonMises4 = sqrt(0.5*((sigGlobal4(1) - sigGlobal4(2))^2 + sigGlobal4(1)^2 + sigGlobal4(2)^2+6*sigGlobal4(3)^2));

criticalCompStress = min([sigmaVonMises1,sigmaVonMises2,sigmaVonMises3,sigmaVonMises4]);

v = D(1,2)/D(2,2);
Ealong = (D(1,1) + D(2,2))/2 * (12*(1-v^2))/(0.015)^3;

%for the mid section only
sigmaH2 = M2.*y(30)./I;
plot(h, sigmaH2);
%

for i = 1:30
%     c20 = -3545.67.*F1./(Ealong.*I(i));
%     c30 = -54220.*F1./(Ealong.*I(i));
%     deflection2(:,i) = -65*F1 .* L2.^2./(2.*Ealong.*I(i)) + c20.*L2 + c30;
    deflection2(:,i) = 65.*10^-3.*F1.*((65.*10^-3)^2+3.*L2.^2-3.*L2.*194.*10^-3)./(6*Ealong.*I(i));
end