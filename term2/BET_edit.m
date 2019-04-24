%This script is to analyse rotorcrafts and propellers using the way of
%splitting blade into pieces
%all the inputs about angles should be in radians except twist(degree)
%the results will be written in a text file called results_bet.txt
%written by Jiaxuan Tang for Computing coursework quesion 2
clc
clear

%ask user for the ASCII file
filename=input('input the full name of the ASCII file(include.dat):','s');
fid=fopen(filename,'r');
trash=fscanf(fid,'%*s',3);%jump the title
%use fscanf to store the value of the file into an array
AOA_VS_CL_CD=fscanf(fid,'%e',[3,inf]);%this will be a nx3 array

%warning: the data in AOA_VS_CL_CD about angle of attack is in unit of
%degree so when calculating angle of attack below, you should also use
%degree

%ask users for the precision settings
R_cut=input('input the slices of blade you want to cut:');
psi_cut=input('input the slices of aziumuth angle you want to divide:');

clc%just show the flying condition

%show the user with display settings;
disp('Here are the helicopter settings;');

%set the initial condition
N=input('input the number of blades(e.g 4):');%blade numbers
D=input('input the diameter of the blade in m(e.g 16.36):');%diameter of the blade
R0=input('input the first airfoil section R0 in m:');
Croot=input('input the root blade chord in m:');
Ctip=input('input the tip blade chord in m:');
E=input('input the linear blade twist in degree:');%degree linear blade twist
angular_velocity=input('input the rotational speed in rad/sec:');%rads s^-1
density=1.22;%density of air kg/m^3

disp('Here are the flight condtion settings:');
ic=input('input the blade setting angle(degree):')*pi/180;%get the blade setting angle,turn it into radian
Vinf=input('input the forward airspeed(ft/s):')*0.551;%forwad speed,input here will be in knots so it should be turned into SI units
Winf=input('input the rate of descent(ft/min):')*0.551/60;%vertical speed downwards
twist=E*pi/180;%input will be degree so turn in to radian

%caluculate the local chord for each small section and the positions of
%them
R=R0:(D/2-R0)/(R_cut-1):(D/2);%Distance from center, value of R
section_chord=((Ctip-Croot)/(D/2-R0)).*(R-R0)+Croot;%the width for each small pieces
psi=0:2*pi/(psi_cut-1):2*pi;%azimuth_angle
Fn_init=0;%set the inital totol thrust

% use cubic spline to calculate corresponding value of CL and CD specific
% angle of attackz
AOA_list=AOA_VS_CL_CD(1,:);
CL_list=AOA_VS_CL_CD(2,:);
CD_list=AOA_VS_CL_CD(3,:);
polyArray_CL=CubicIn(AOA_list,CL_list);
polyArray_CD=CubicIn(AOA_list,CD_list);

%use meshgrid to turn 1D array to matrix(R,section_chord,azimuth_angle(psi)
%as the dimension should be constant
[~,section_chord]=meshgrid(psi,section_chord);
[psi,R]=meshgrid(psi,R);

Diff=5;%set the initial difference
is_solution=1;%set a condition for the invalid solution
is_dangerous=1;
while (Diff>0.0001)
    %this nested loop is to create 200x360 array as both the blade section are divided by R_cut and
    %the azimuth angle are divided into psi_cut pieces 
    %i represents sections and j represents azimuth angle so one column
    %represents same azimuth angles, different sections.
    %calculate the velocity normal to disc W
    if Winf<=0
        W=(0.5*Winf)-0.5*sqrt(Winf^2+8*Fn_init/(pi*density*D^2));
    elseif Winf >sqrt(8*Fn_init/(density*pi*D^2))
        W=(0.5*Winf)+0.5*sqrt(Winf^2-8*Fn_init/(pi*density*D^2));
    else
        %if the w will not have solution,change the state of the is_solution
        disp('No analytical solution.');
        is_solution=0;
        break
    end
    %nested loops can also be used to calculate all the values in the matrix, easier
    %to use array operations
    VT=angular_velocity.*R+Vinf.*sin(psi);%to calculate tangential velocity
    Ve=sqrt(VT.^2+W.^2);%to calculate downward velocity;
    deltaA=atan(W./VT);
    ae=ic+((R-R0)./(D/2-R0)).*twist+deltaA;%to calculate angle of attack(use degree)
    %cubicEval function only receives scarlar,thus nested loops should be
    %used here
    for i=1:R_cut
        for j=1:psi_cut
            CL(i,j)=cubicEval(AOA_list,polyArray_CL,(ae(i,j)*180)/pi);
            CD(i,j)=cubicEval(AOA_list,polyArray_CD,(ae(i,j)*180)/pi);%use function created before to find corresponding CD and CL
        end
    end
    d_Fn=0.5.*density.*(Ve.^2).*section_chord.*(CL.*cos(deltaA)+CD.*sin(deltaA));
    Fn=trapz(psi(1,:),trapz(R(:,1),d_Fn,1),2).*N./(2*pi);%calculate fn in each round until answer goes convergent
    Diff=abs(Fn-Fn_init);%make the answer convergent
    Fn_init=Fn;
end
%use trapz function of calculate double integrals
%calculate total thrust of the rotor disc
%first integrate by Radius then by psi

if is_solution==1%only if analytical solution exists, code below will show
    d_Fx=N*(0.5*density.*Ve.^2).*section_chord.*(CD.*cos(deltaA)-CL.*sin(deltaA)).*sin(psi)./(2*pi);
    Fx=trapz(psi(1,:),trapz(R(:,1),d_Fx));

	d_Fy=-N*(0.5*density.*Ve.^2).*section_chord.*(CD.*cos(deltaA)-CL.*sin(deltaA)).*cos(psi)./(2*pi);
    Fy=trapz(psi(1,:),trapz(R(:,1),d_Fy));

    d_T=N*(0.5*density.*Ve.^2).*section_chord.*(CD.*cos(deltaA)-CL.*sin(deltaA)).*R./(2*pi);
    T=trapz(psi(1,:),trapz(R(:,1),d_T));

    %calculate driven power
    P=T*angular_velocity;

    %calculate pitching and rolling moments
    d_Mx=-N*(0.5*density.*Ve.^2).*section_chord.*(CL.*cos(deltaA)+CD.*sin(deltaA)).*R.*cos(psi)./(2*pi);
    Mx=trapz(psi(1,:),trapz(R(:,1),d_Mx));

    d_My=-N*(0.5*density.*Ve.^2).*section_chord.*(CL.*cos(deltaA)+CD.*sin(deltaA)).*R.*sin(psi)./(2*pi);
    My=trapz(psi(1,:),trapz(R(:,1),d_My));

    %all values are worked out
    %open a text file and write the value in it
    fid1=fopen('results_bet.txt','w');
    fprintf(fid1,'The total thrust is %1$5.3e N \n',Fn);

    fprintf(fid1,'The drag force is %1$5.3e N \n',Fx);

    fprintf(fid1,'The side force is %1$5.3e N \n',Fy);

    fprintf(fid1,'The moment about the rotor hub is %1$5.3e Nm \n',T);

    fprintf(fid1,'Average pitching moment is %1$5.3e Nm \n',Mx);

    fprintf(fid1,'Average rolling moment is %1$5.3e Nm \n',My);

    fprintf(fid1,'The average power to drive the rotor is %1$5.3e W \n',P);
    fclose(fid1);
else%if no analytical solution, nothing will display
    disp('Calculation failed');
end    

