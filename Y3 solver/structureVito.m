clear
clc

c1 = cos(45/180*pi);
s1 = sin(45/180*pi);
Tsig1 = [c1^2,s1^2,2*c1*s1;s1^2,c1^2,-2*c1*s1;-c1*s1,c1*s1,(c1^2-s1^2)];
Teta1 = [c1^2,s1^2,c1*s1;s1^2,c1^2,-c1*s1;-2*c1*s1,2*c1*s1,(c1^2-s1^2)];
c2 = cos(90/180*pi);
s2 = sin(90/180*pi);
Tsig2 = [c2^2,s2^2,2*c2*s2;s2^2,c2^2,-2*c2*s2;-c2*s2,c2*s2,(c2^2-s2^2)];
Teta2 = [c2^2,s2^2,c2*s2;s2^2,c2^2,-c2*s2;-2*c2*s2,2*c2*s2,(c2^2-s2^2)];
Q = [40 4 0;4 10 0;0 0 4];
Q1 = Tsig1^(-1)*Q*Teta1
Q2 = Tsig2^(-1)*Q*Teta2

syms eX eY

[ans1,ans2] = solve(64*eX+2.4*eY==0,2.4*eX + 64*eY==1.3);
fprintf("The value of eXX is %10.5g\n",ans1);
fprintf("The value of eYY is %10.5g\n",ans2);