%n-V diagram for structural sizing
clear
clc

V0 = 0 : 1 : 330    %Equivalent airspeed in knots
S = 59; %wing area
CLmax = 1.37;   %aircraft positive CL max
CLmin = -CLmax*0.8; % CL min
nmax = 2.5; nmin = -1;
W = 20829*9.81;
for i = 1 : length(V0)
    if 0.5*1.225*V0(i).^2*59*CLmax/W <= nmax
        Ls(i) = 0.5*1.225*V0(i).^2*59*CLmax/W;
    else
        Ls(i) = nmax;
    end
    if 0.5*1.225*V0(i).^2*59*CLmin/W >= nmin
        Lsn(i) = 0.5*1.225*V0(i).^2*59*CLmin/W;
    else
        Lsn(i) = nmin;
    end    
end
figure (1)
plot(V0,Ls,V0,Lsn,'linewidth',2)
line([330 330],[-1 2.5],'linewidth',2)
grid on
xlabel('Equivalent Airspeed / knots','interpreter','latex','fontsize',12)
