%avd u/c calculation
%for main u/c 4 wheels per struct, nose gear 2 wheels

%3 structs total

%Assume the tire pressure

%
clc
clear

%% place the u/c
heightOfCg = input("Type the height of the Center of gravity");%m
W0 = 145e3;%kg
Wmg = W0*0.9;
Wng = W0*0.1;

Xng = 2.5;
Xmg = 25.3;
Xcg = (Wng.*Xng + Wmg.*Xmg)./W0;
%now check the 6'' clearence
%% check the tip back angle
totalLength = 56;
tipBackAngle = atan((2+2.8)/(totalLength - Xmg))/pi*180;
tipBack = true;
verticalCgAngle = (atan((Xmg - Xcg)/heightOfCg)/pi*180);
if verticalCgAngle > tipBackAngle
    tipBack = false;
end

%% check overturn
yPosMg = 3.9;
angle1 = atan(yPosMg/(Xmg - Xng));
staticGroundLine = (Xcg - Xng)*sin(angle1);
overturnAngle = atan(heightOfCg/staticGroundLine)/pi*180;
willOverTurn = true;
if overturnAngle <= 63
    willOverTurn = false;
end

Wdynamic = 10*heightOfCg*W0/(Xmg-Xng);




