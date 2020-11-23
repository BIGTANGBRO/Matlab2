function [x,h,t,p0,p,xt,ts,prf] = supersoniclab2020(runtime, pe_inp, te)
%
% COMPRESSIBLE FLOW LAB MATLAB SCRIPT
%
% Matlab code for 3rd year compressible flow laboratory 
% (AE3-301 Aircraft Aerodynamics, supervisor: Dr. Paul Bruce)
%
%--------------------------------------------------------------------------
%
% INPUT:
%  runtime - String for date and time of pressure data files. Formatted as 
%            follows: 'yyyy-mm-dd_hh-mm-ss'. Full input file names will be 
%            populated within this code to give final names of .csv files     [%s] 
%            For example: 
%                 2020-02-16_16-46-38_NetScannerResults1.csv 
%                 2020-02-16_16-46-38_NetScannerResults2.csv
%  pe_inp  - Atmospheric pressure (Bar)
%  te      - Atmospheric temperature (degrees)

%
% SYNTAX:
%
%           supersoniclab2020('2017-02-27_18-27-01',atm pressure, temperature)
% OUTPUT:
%  x     - Nozzle geometry, streamwise direction from nozzle part LE  [mm]
%  h     - Nozzle geometry, height of channel - h = f(x)              [mm]
%  t     - Test time                                                  [s]
%  p0    - Settling chamber total pressure, corrected for local flow  [Pa]
%  p     - Pressure matrix (time series x tap location)               [Pa]
%  xt    - Pressure tap location along centerline                     [mm]
%  ts    - Time limits for profiles (profile no. x [min(t) max(t)])   [s]
%  prf   - Normalised mean pressure profiles, p/p0                    [Pa]
%
%--------------------------------------------------------------------------
%
% PROCEDURE:
%  1) Ensure the nozzle geometry file <icswt_geometry.csv>, pressure 
%     data file and this code (<supersoniclab.m>) are all located in the 
%     same folder set as the current directory.
%  2) Run .m file in matlab using the command...
%       '[x,h,t,p0,p,xt,ts,prf] = supersoniclab(fname)' 
%     ...where <fname> is the filename of the pressure data file including 
%     the .csv extension, for example - 'pdata.csv'.
%  3) On the total pressure plot click start and end times for each desired
%     pressure profile, do not be concerned by y location of click as this
%     is ignored within the code.
%  4) Process output data as required by lab handout
%
%--------------------------------------------------------------------------
% 
% OTHER INFORMATION:
%  Tunnel working section features a 2D convergent-divergent cross section
%  with constant width of 150 mm and total length 1000 mm. The settling 
%  chamber measures 280 mm in diameter. The total upstream pressure is 
%  measured using a pressure tap located in the settling chamber, 
%  corrected for anticipated local flow.
%
%  Pressure is sampled using a maximum 32 channels and output as a .csv
%  file where the first column represents test time [s], and each
%  subsequent column represents an individual channel (from 1 to 32).
%
%  Pressures in working section are measured along the centerline of the
%  flat wall using a series of pressure tappings fitted to the first two
%  wall panels.




    %% FUNCTION INITIALISATION
    close all
    clc
    plotAni=1;
    warning off
    plotedit off

    % Update status to user
    fprintf('========= 3RD YEAR COMPRESSIBLE FLOW LABORATORY ANALYSIS =========\n')
    fprintf('         (AE3-301 Aircraft Aerodynamics - Dr. Paul Bruce)       \n')
    fprintf('                      (%s)\n\n',datestr(clock))
    fprintf('Call function using: [x,h,t,p0,p,xt,ts,prf] = supersoniclab(fname)\n\n')
    
    % Start process timer
    tic
    Np = 3;
    % Set script defaults
    set(0,'DefaultFigureWindowStyle','docked')

    %% USER INPUT VARIABLES

    % Update status to user
    fprintf(' - Reading user input variables...\n')

    % Define filenames - make sure these files are in current folder
    NSfile1 = '_NetScannerResults1.csv';
    NSfile2 = '_NetScannerResults2.csv';
    fNameGeo = 'icswt_geometry_Mach2.0.csv'; % CSV file containing geometry data

    % Nozzle geometry
    Wws = 150; % Width of working section               [mm]
    Dsc = 280; % Effective diameter of settling chamber [mm]

    % Gas parameters
    global gamma % Declare global variable
    gamma = 1.4; % Ratio of specific heats [-]

    % Analysis settings
    %Np = 3;   % Number of profiles to plot [-]

    % Tapping locations and channel information
    isc = 16;             % Channel of SC pressure value [-]
    ch = [1:13,16,17:30]; % Monitered channel numbers    [-]

    % Plotting formatting
    col = [{'b'},{'g'},{'m'},{'c'},{'k'}];
    mrk = [{'o'},{'s'},{'^'},{'v'},{'d'}];


    %% INPUT DATA FROM .CSV FILES

    % Update status to user
    fprintf(' - Importing data...\n')

    % Import and format geometry data
    gData = importdata(fNameGeo); % Import data from file
    x = gData.data(:,1);          % Streamwise location [mm]
    h = gData.data(:,2);          % Channel height      [mm]
    clear fNameGeo gData

    % Format input datafile names
    fname1 = [runtime,NSfile1];
    fname2 = [runtime,NSfile2];

    % Import and format run test data
    data1 = importdata(fname1);
    data2 = importdata(fname2);

    % Find size of data [-]
    Nt = min(size(data1.data,1),size(data2.data,1)); % Number of timesteps
    Nc = length(ch); % Number of channels

    % Read time variable
    t = data1.data(1:Nt,1);

    % Initialise variables
    p  = zeros(Nt,32);
    xt = zeros(1,32);

    % Populate pressure variable
    p(:, 1:16) = data1.data(1:Nt,2:17)*1e5;
    p(:,17:32) = data2.data(1:Nt,3:18)*1e5;

    % Read channel positions [mm]
    for ii = 1:16
        xt(ii)    = str2double(data1.colheaders{ii+1}(strfind(data1.colheaders{ii+1},'(')+1:strfind(data1.colheaders{ii+1},')')-3));
        xt(ii+16) = str2double(data2.colheaders{ii+2}(strfind(data2.colheaders{ii+2},'(')+1:strfind(data2.colheaders{ii+2},')')-3));
    end

    % Exit pressure (atmospheric pressure) [Pa]
    pe = pe_inp * 1e5;
    te_val = te;
    
    clear data1 data2

    % Settling chamber pressure [Pa]
    psc = p(:,isc);


    %% ANALYSIS

    % Update status to user
    fprintf(' - Analysing data...\n')

    % Isentropic inviscid pressure distribution
    ht = min(h);
    [Ma,Mb] = area2mach(h/ht);
    Misen = zeros(size(Ma));
    Misen(1:find(h==ht,1,'first')-1) = Ma(1:find(h==ht,1,'first')-1);
    Misen(find(h==ht,1,'first'):end) = Mb(find(h==ht,1,'first'):end);
    clear Ma Mb

    pisen = 1./(1 + (gamma-1)*Misen.^2/2).^(gamma/(gamma-1));

    % Sort order of pressure tappings by streamwise location [-]
    [~,chsort] = sort(xt(ch));

    % Limit data to channels of concern
    xt = xt(ch(chsort));  % Streamwise location of pressure taps [mm]
    p  = p(:,ch(chsort)); % Static pressures                     [Pa]

    % Settling chamber
    Asc     = (pi*Dsc^2*0.25) / (min(h)*Wws); % Area ratio SC to throat [-]
    [Msc,~] = area2mach(Asc);                 % Mach number in SC       [-]
    clear Wws Dsc Asc

    % SC total pressure [Pa]
    p0 = psc*(1+(gamma-1)*0.5*Msc^2)^(gamma/(gamma-1)); 

    % Static pressures at taps
    pn = p./repmat(p0,[1 Nc]); % Normalised pressure ratio (p/p0) [-]
    clear Msc isc

    %% PLOT SETTLING CHAMBER TOTAL PRESSURE RATIO TIME SERIES

    % Update status to user
    fprintf(' - Plotting tunnel total pressure ratio...\n')

    % Create figure
    figure, hold on, grid on, box on

    % Plot data 
    plot(t,p0/pe,'r')    
    
    % Format plot
    set(gca,'FontSize',12)
    xlim([min(t) max(t)]), ylim([.98 max(p0/pe)*1.05])
    xlabel('Time - t [s]','FontSize',14)
    ylabel('Pressure ratio - p_0/p_e [-]','FontSize',14)
    title('Normalised pressure ratio time series plot','FontSize',14)
    
    
    %clear Fs Ft



    % Collect range data for determining pressure profiles
    fprintf('\n *** Click at the upper and lower limits for %i input ranges ***\n\n',Np)
    ts = ginput(Np*2);
    ts(:,2) = [];
    ts = sort(ts);
    ts = [ts(1:2:Np*2-1),ts(2:2:Np*2)];

    % Plot required ranges on current figure
    for ii = 1:Np
        plot(repmat(ts(ii,1),2),[1 interp1(t,p0/pe,ts(ii,1))],['- o ',col{ii}])
        plot(repmat(ts(ii,2),2),[1 interp1(t,p0/pe,ts(ii,2))],['- o ',col{ii}])
    end, clear ii


    pause(3);

    % Find corresponding indicies for time series
    is(1:Np,1) =  ceil(interp1(t,1:Nt,ts(1:Np,1))); % Start of range [-]
    is(1:Np,2) = floor(interp1(t,1:Nt,ts(1:Np,2))); % End of range   [-]

    %% CALCULATING DESIRED PRESSURE PROFILES

    % Update status to user
    fprintf(' - Calculating desired pressure profiles...\n')

    % Initialise variable
    %prf = zeros(Np,Nc);
    %%%%%%%%%%%%%%%%%%%%%
    if Np==0
    prf = zeros(1,Nc);
    else
    prf = zeros(Np,Nc);    
    end
    %%%%%%%%%%%%%%%%%%%%%


    
    % Create figure
    figure, hold on, grid on, box on

    % Loop through each profile
    %%%%%%%%

    if Np>0
    %%%%%%%%%
    for ii = 1:Np
        prf(ii,:) = mean(pn(is(ii,1):is(ii,2),:),1);

        p1 = plot(xt,prf(ii,:),[mrk{ii},col{ii}],...
            'MarkerSize',10,'LineWidth',2);
    end, clear ii
    %%%%%%%%%%%
    end
    plot(x,pisen,'k')
    fplot(0.37,[min(xt) max(xt)],'m--')
    fplot(0.1247,[min(xt) max(xt)],'k--')
    %fplot(0.,[min(xt) max(xt)],'g--')
    fplot(0.759,[min(xt) max(xt)],'g-.')
      %fplot(0.,[min(xt) max(xt)],'b--')
    %%%%%%%%%%%%%%%
    % Format plot
    set(gca,'FontSize',12)
    xlim([min(xt) max(xt)]), ylim([0 1])
    xlabel('Nozzle location - x [mm]','FontSize',14)
    ylabel('Mean normalised pressure - p/p_0 [-]','FontSize',14)
    title('Normalised pressure profile plots','FontSize',14)
     
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%


    %% TERMINATE MAIN CODE

    warning on

    % Update status to user
    fprintf(' - Exporting results to variables...\n')
    fprintf('\n======================= ANALYSIS  COMPLETE =======================\n')
    fprintf('                    (Processing time = %.2f s)\n',toc)

end

%% Area ratio to Mach number function
function [ Msubsonic,Msupersonic ] = area2mach( Aratio )
%[ Msubsonic,Msupersonic ] = area2mach( Aratio )
%   Uses mach2area function

    % Number of values in lookup table
    N  = 1000;
    
    % Create Mach number lookup table
    Mai = linspace(0.001,1,N/2);
    Mbi = linspace(1,5,N/2);
    
    % Create area ratio lookup table
    Aai = mach2area(Mai);
    Abi = mach2area(Mbi);
    
    % Interpolate to find values
    Msubsonic   = interp1(Aai,Mai,Aratio);
    Msupersonic = interp1(Abi,Mbi,Aratio);
end

%% Mach number to area ratio function
function [ Arat ] = mach2area( M )
%[ Arat ] = mach2area( M )

    % Ratio of specific heats
    global gamma
    
    % Area-Mach relation
    Arat  = ((1 + (gamma-1)*M.^2/2)*2/(gamma+1)).^((gamma+1)/(2*gamma-2))./M;
end