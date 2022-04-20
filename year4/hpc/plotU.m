clear
clc
%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [1, Inf];
opts.Delimiter = " ";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "e08", "VarName4"];
opts.SelectedVariableNames = ["e08", "VarName4"];
opts.VariableTypes = ["string", "string", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";
opts.LeadingDelimitersRule = "ignore";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2"], "EmptyFieldRule", "auto");

% Import the data
output = readtable("C:\Users\tangj\Desktop\Code\Matlab2\year4\hpc\outputTest1.txt", opts);

%% Convert to output type
output = table2array(output);

%% Clear temporary variables
clear opts
u = output(:,1);
v = output(:,1);
Nx = 151;
Ny = 81;
U = zeros(Ny, Nx);
V = zeros(Ny, Nx);
for i = 0:Ny-1
    startPoint = 1*i + Nx * i + 1;
    endPoint = startPoint + Nx-1;
    rowU = u(startPoint:endPoint).';
    rowV = v(startPoint:endPoint).';

    U(i+1,:) = rowU;
    V(i+1,:) = rowV;
end

x = linspace(0,Nx-1,Nx);
y = linspace(0,Ny-1,Ny);

figure(1)
pcolor(x,y,U);
colorbar

figure(2)
pcolor(x,y,V);
colorbar