clear
clc

irrAvgLoop = [4.0911, 3.8635,5.1235,5.4454];
irrMaxLoop = [6.9793, 5.6624,7.0322,7.5132];

irrAvgMb = [4.0911, 3.8637,3.8076,3.8030];
irrMaxMb = [6.9793,7.7939,8.1289,8.1289];

irrAvgRoot = [4.0911, 3.3160,4.7823,5.3181];
irrMaxRoot = [6.9793,5.0810,6.6063,7.2999];

%% 
regularAvgLoop = [2.288, 2.4802,2.6508,2.6874];
regularMaxLoop = [4.1410,4.6157,4.6570,4.9502];

regularAvgMb = [2.288, 2.2069,2.2565,2.2868];
regularMaxMb = [4.1410,4.3422,4.4187,4.4648];

regularAvgRoot = [2.288, 2.5390,2.6366,2.6756];
regularMaxRoot = [4.1410,4.5305,4.6873,4.7910];

irrhloop = [65.236, 31.240, 15.435,  7.693];
irrhMb =   [65.236, 33.230, 16.708,  8.369];   
irrhRoot = [65.236, 36.215, 20.620,  11.839];

regularhloop = [25.733	12.768, 6.364, 3.178];
regularhMb =   [25.733 12.920, 6.473, 3.239];
regularhRoot = [25.733 14.767, 8.452, 4.890];

figure(1)
plot(irrhloop,irrAvgLoop);
hold on
plot(irrhMb,irrAvgMb);
hold on
plot(irrhRoot,irrAvgRoot);

figure(2)
plot(regularhloop,regularAvgLoop);
hold on
plot(regularhMb,regularAvgMb);
hold on
plot(regularhRoot,regularAvgRoot);

figure(3)
plot(irrhloop,irrMaxLoop);
hold on
plot(irrhMb,irrMaxMb);
hold on
plot(irrhRoot,irrMaxRoot);

figure(4)
plot(regularhloop,regularMaxLoop);
hold on
plot(regularhMb,regularMaxMb);
hold on
plot(regularhRoot,regularMaxRoot);
