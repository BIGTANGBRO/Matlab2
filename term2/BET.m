%Script that approximates the side and drag forces, the average rotor 
%torque acting on a rotor disk, and the power requirement to drive the
%rotor for a rotor disk of user-specified geometry travelling at a 
%user-specified air velocity with vertical and forward components.
%Written by Jonathan De Sousa
%Credit to Dr Errikos Levis for cubicEval.m function
%Date: 23-03-2019

%Clear workspace and screen and close all open figures
clear
clc
close all

%Prompt user to input operating conditions
disp('OPERATING CONDITIONS')    
omega=input('Input rotor angular velocity (rad/s): ');
i_c=input('Input collective blade setting angle (degrees): ');
V_inf=input('Input forward airspeed (m/s): ');
W_inf=input('Input rate of descent (m/s): ');
rho=input('Input air density (kg/m^3): ');

clc %clear screen

%Prompt user to define rotor geometry
disp('ROTOR GEOMETRY')
N=input('Input number of blades: ');
D=input('Input rotor diameter (m): ');
R_0=input('Input blade starting radius (m): ');
c_root=input('Input root chord length (m): ');
c_tip=input('Input tip chord length (m): ');
epsilon=input('Input blade twist angle from root to tip (degrees): ');

%Change user-input angles into radians
i_c=pi*i_c/180;
epsilon=pi*epsilon/180;

clc %clear screen

%Prompt user for full file name of ASCII file containing lift and drag 
%coefficients at different angles of attack.
filename=input('Input full name of file containing aerodynamic characteristics of airfoil: ','s');


%Load file
fID=fopen(char(filename),'r');

%Read file
fscanf(fID,'%s',3); %skip first three lines (table headings)
data=fscanf(fID,'%f',[3,inf]); %extract data from file

%Transpose data array and separate data into categories
data=data';
AoA=data(:,1); %angles of attack
CL=data(:,2); %corresponding coefficients of lift
CD=data(:,3); %corresponding coefficients of drag

%Discretize rotor blade 
m_R=100; %number of discrete rotor sections to carry out calculations
R=(R_0:((D/2-R_0)/(m_R-1)):D/2); %distances of each section from rotor disc centre (m)
%Calculate local chord for each discretized section using linear
%interpolation
c_local=((c_tip-c_root)/(D/2-R_0)).*(R-R_0)+c_root;

%Set constants
Fn_old=0; %initial thrust force of rotor disc (N)
m_psi=360; %number of discretized azimuth angles
psi=(0:2*pi/(m_psi-1):2*pi); %azimuth angles of the blade (rad)
diff=99; %difference between successive calculated total thrust values

%Pre-allocate arrays
V_e=zeros(m_psi,m_R);
delta_alpha=zeros(m_psi,m_R);
CL_InterpVal=zeros(m_psi,m_R);
CD_InterpVal=zeros(m_psi,m_R);

%Turn c_local, psi and R arrays into square arrays
c_local=c_local.*ones(m_psi,m_R);

psi2=psi;
R2=R;
for count = 1:m_R-1
    psi=[psi;psi2];
    R=[R;R2];
end

%Loop iterative calculation of total thrust force, Fn, until Fn converges
while diff>eps %eps is computational precision
    for i=1:m_psi
        for j=1:m_R
            %Calculate total air velocity normal to the rotor plane (m/s)
            if W_inf<=0
                W=(W_inf/2)-0.5*sqrt(W_inf^2+8*Fn_old/(rho*pi*D^2));
            elseif W_inf>sqrt(8*Fn_old/(rho*pi*D^2))
                W=(W_inf/2)+0.5*sqrt(W_inf^2-8*Fn_old/(rho*pi*D^2));
            else
                %Display warning since rotorcraft is in Vortex Ring State
                disp('WARNING: ROTORCRAFT IS IN DANGEROUS VORTEX RING STATE')
                break %break loop
            end
            %Calculate tangential velocity to blade in rotor disc plane (m/s)
            V_T=omega*R(j)+V_inf*sin(psi(i));
            %Calculate local airspeed in plane of blade element (m/s)
            V_e(i,j)=sqrt(V_T^2+W^2);
            %Calculate local rotation of the airflow relative to the plane of
            %the disk (rad)
            delta_alpha(i,j)=atan(W/V_T);
            %Calculate angle of attack (rad) of blade element
            alpha_e=i_c+((R(j)-R_0)*epsilon/(D/2-R_0))+delta_alpha;
            %Use cubic spline interpolation to find coefficients of drag and
            %lift at each section using cubicEval.m and coeff.m functions used
            %in Cubic Spline Interpolation question
            polycoeff1=CubicIn(AoA,CL); %calculate polynomial coefficients of interpolant
            CL_InterpVal(i,j)=cubicEval(AoA,polycoeff1,alpha_e); %interpolated CL value
            polycoeff2=CubicIn(AoA,CD); %calculate polynomial coefficients of interpolant
            CD_InterpVal(i,j)=cubicEval(AoA,polycoeff2,alpha_e); %interpolated CD value
        end
    end
    
    %Calculate total thrust force Fn_new of the rotor disc
    dFn=0.5*rho*V_e.^2.*c_local.*(CL_InterpVal.*cos(delta_alpha)+CD_InterpVal.*sin(delta_alpha));
    Fn_new=(N/(2*pi))*trapz(psi,trapz(R,dFn));
    
    %Calculate difference between successive thrust force values
    diff=abs(Fn_new-Fn_old);
    Fn_old=Fn_new;
end

%Calculate drag force
dFx=0.5*rho*V_e.^2.*c_local.*(CD_InterpVal.*cos(delta_alpha)-CL_InterpVal.*sin(delta_alpha)).*sin(psi);
Fx=(N/(2*pi))*trapz(psi,trapz(R,dFx));

%Calculate side force
dFy=0.5*rho*V_e.^2.*c_local.*(CD_InterpVal.*cos(delta_alpha)-CL_InterpVal.*sin(delta_alpha)).*cos(psi);
Fy=-(N/(2*pi))*trapz(psi,trapz(R,dFy));

%Calculate the average torque over the rotor
dT=0.5*rho*V_e.^2.*c_local.*(CD_InterpVal.*cos(delta_alpha)-CL_InterpVal.*sin(delta_alpha)).*R;
T=(N/(2*pi))*trapz(psi,trapz(R,dT));

P=T*omega; %power P required to drive the rotor

%Calculate the pitching 
dMx=0.5*rho*V_e.^2.*c_local.*(CL_InterpVal.*cos(delta_alpha)+CD_InterpVal.*sin(delta_alpha)).*R.*cos(psi);
Mx=-(N/(2*pi))*trapz(psi,trapz(R,dMx));

%Calculate the rolling moment
dMy=0.5*rho*V_e.^2.*c_local.*(CL_InterpVal.*cos(delta_alpha)+CD_InterpVal.*sin(delta_alpha)).*R.*sin(psi);
My=-(N/(2*pi))*trapz(psi,trapz(R,dMy));

%Display results
disp(['Total thrust force: ',num2str(Fn),' N']);
disp(['Drag force: ',num2str(Fx),' N']);
disp(['Side force: ',num2str(Fy),' N']);
disp(['Rolling moment: ',num2str(My),' Nm']);
disp(['Pitching moment: ',num2str(Mx),' Nm']);
disp(['Power to drive rotor: ',num2str(P),' W']);


        
        
        
        
        






