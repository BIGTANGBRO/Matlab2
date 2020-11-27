clear
clc

A = mach2area(2);

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
function [ Arat ] = mach2area( M )
%[ Arat ] = mach2area( M )

    % Ratio of specific heats
    global gamma
    
    % Area-Mach relation
    Arat  = ((1 + (gamma-1)*M.^2/2)*2/(gamma+1)).^((gamma+1)/(2*gamma-2))./M;
end