%find the critical mach number under the effects of sweep
%using iteration
clear
clc

Cpi= -0.452;
%pg relatio
mindiff = 10;
sweepAngle = 26;

for m = 0.7:0.01:0.95
    cpStar = 2/(1.4*m^2)*(((1+0.2*m^2*cos(sweepAngle/180*pi)^2)/(1+0.2))^(1.4/0.4)-1);
    %pg relation
    cpMin = Cpi*cos(sweepAngle/180*pi)/sqrt(1-m^2*cos(sweepAngle/180*pi)^2);
    diff = abs(cpMin-cpStar);
    
    if diff < mindiff
        mindiff = diff;
        mcrit = m;
    else
        break;
    end
end