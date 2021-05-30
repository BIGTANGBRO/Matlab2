%% Housekeeping
close all
clc
clear
%% Initiate variables
run('variables.m');
mdl = 'sim_0_1';
k = 10;
o = 10;
Masses = 69 + [0:(k-1)];
FricCoeffs = (8 + ([1:o] * 0.2)) / 1e4;
DragCoeffs = 0.07 + [0:(k-1)] * 0.01;
FrontalAreas = 0.2 + [1:o] * 0.05;
%% Check sensitivity for mass and friction coefficient
energyMass = zeros(k, o);
for (i = 0:(k-1))
    for (j = 1:o)
        in(k * i + j) = Simulink.SimulationInput(mdl);
        in(k * i + j) = in(k * i + j).setVariable('m', Masses(i+1));
        in(k * i + j) = in(k * i + j).setVariable('mi', FricCoeffs(j));
    end
end

out = parsim(in, 'ShowProgress', 'on'); %run simulations

for (i = 0:k-1)
    for (j = 1:o)
        energyMass(i + 1, j) = out(k * i + j).Energy;
    end
end
%% Reset to default values after finished simulation
run('variables.m');
%% Check sensitivity for frontal area and drag coefficient
energyDrag = zeros(k, o);
for (i = 0:(k-1))
    for (j = 1:o)
        in(k * i + j) = Simulink.SimulationInput(mdl);
        in(k * i + j) = in(k * i + j).setVariable('cd', DragCoeffs(i+1));
        in(k * i + j) = in(k * i + j).setVariable('A', FrontalAreas(j));
    end
end

out = parsim(in, 'ShowProgress', 'on'); %run simulations

for (i = 0:k-1)
    for (j = 1:o)
        energyDrag(i + 1, j) = out(k * i + j).Energy;
    end
end
%% Plot results
subplot(2,1,1);
plot(Masses, energyMass);
title("Performance sensitivity to mass changes");
ylabel("Total Energy Used [Wh]");
xlabel("Mass of vehicle [kg]");
subplot(2,1,2);
plot(DragCoeffs, energyDrag);
title("Performance sensitivity to profile changes");
ylabel("Total Energy Used [Wh]");
xlabel("Drag Coefficient");
