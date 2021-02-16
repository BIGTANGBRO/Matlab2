% preliminary light frame sizing 
clear
clc
close all

E=73e9; % young's modulus 
D=3; %fuselage diameter
L=0.5; % frame spacing
M=3.7074e6; % fuselage maximum bending moment
C_f=0.0000625; %empirical value, based on pass aircraft data

%calculate the stiffness of the frame
EI=C_f*M*D^2/L;
I=EI/E;

% determine the minimum thickness of the C section frame
b=[0.01:0.01:0.05];
h=[0.05:0.01:0.10];
for i=1:length(b)
   for j=1:length(h)
       t(i,j)=I/(h(j)^3/12+b(i)*h(j)^2/2); 
       A(i,j)=(2*b(i)+h(j))*t(i,j);
   end
end
b(2)
h(2)
t(2,2)
A(2,2)

b1=[0.05:0.01:0.10];
h1=[0.01:0.01:0.06];
% determine the minimum thickness of hat section
for i=1:length(b1)
   for j=1:length(h1)
       third=b1(i)/18+b1(i)/12;
       first=h1(j)^3/6+b1(i)*h1(j)^2/6+b1(i)*h1(j)^2/4;
       ze=I;
       p=[third,0,first,-ze];
       c=roots(p);
       t_h(i,j)=c(3);
       A_h(i,j)=(5/3*b1(i)+2*h1(j))*t_h(i,j);
   end
end
b1(2)
h1(4)
t_h(2,4)
A_h(2,4)
