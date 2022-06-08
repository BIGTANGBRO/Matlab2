clear
clc

irrAvgLoop = [2.521, 2.413, 3.600, 3.894];

irrAvgMb = [2.521, 2.351, 2.337, 2.337];

irrAvgRoot = [2.521, 1.897, 3.307, 3.769];

%% 
regularAvgLoop = [0.385, 0.818, 1.013, 1.064];

regularAvgMb = [0.385, 0.370, 0.368, 0.367];

regularAvgRoot = [0.385, 0.735, 0.959, 1.037];

irrhloop = [65.236, 31.240, 15.435,  7.693];
irrhMb =   [65.236, 33.230, 16.708,  8.369];   
irrhRoot = [65.236, 36.215, 20.620,  11.839];

regularhloop = [25.733	12.768, 6.364, 3.178];
regularhMb =   [25.733 12.920, 6.473, 3.239];
regularhRoot = [25.733 14.767, 8.452, 4.890];

figure(1)
plot(irrhloop,irrAvgLoop, 'o-');
hold on
plot(irrhMb,irrAvgMb, '*-');
hold on
plot(irrhRoot,irrAvgRoot, '->');
%% 
grid on
xlabel("Element size/mm");
ylabel("Relative error in radius");
legend("Loop", "Modified Butterfly", "$\sqrt(3)$");

figure(2)
plot(regularhloop,regularAvgLoop, 'o-');
hold on
plot(regularhMb,regularAvgMb, '*-');
hold on
plot(regularhRoot,regularAvgRoot, '->');
grid on
xlabel("Element size/mm");
ylabel("Relative error in radius");
legend("Loop", "Modified Butterfly", "$\sqrt(3)$");
