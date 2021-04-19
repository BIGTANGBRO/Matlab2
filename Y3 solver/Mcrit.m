%find the critical mach number
%using iteration

clear
clc

Cpi= input("input the value of Cpi");
%pg relatio
mindiff = 10;

cpArr1 = [];
cpArr2 = [];
cpArr3 = [];
mArr = [];

for m = 0.3:0.01:0.85
    cpStar = 2/(1.4*m^2)*(((1+0.2*m^2)/(1+0.2))^(1.4/0.4)-1);
    %pg relation
    cpMin1 = Cpi/sqrt(1-m^2);
    %von karman-tsien
    cpMin2=Cpi/(sqrt(1-m^2)+m^2/(1+sqrt(1-m^2))*0.5*Cpi);
    %Laiton relation
    cpMin3=Cpi/(sqrt(1-m^2)+m^2/(2*sqrt(1-m^2))*(1+0.2*m^2)*Cpi);
    
    cpArr1 = [cpArr1 cpMin1];
    cpArr2 = [cpArr2 cpMin2];
    cpArr3 = [cpArr3 cpMin3];

    mArr = [mArr m];
    
    diff = abs(cpMin1-cpStar);
    
    if diff < mindiff
        mindiff = diff;
        mcrit = m;
    else
        break;
    end
end

disp(mcrit);
plot(mArr,-cpArr1);
hold on
plot(mArr,-cpArr2);
hold on
plot(mArr,-cpArr3);
legend("PG","Vonkarman","laitone")