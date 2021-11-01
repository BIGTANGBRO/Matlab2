% Script written for processing of Low Speed Flow Past a High Aspect Ratio
% Swept Wing lab 
% This script is based on a file originally developed by Emilia Juda, Aeronautics Class of 2018

% housekeeping
clear
clc
close all

% load data from sections and pitot data
raw_data = readtable('data.xlsx');
aoa = [table2array(raw_data(73,'Run1')), table2array(raw_data(73,'Run2')), table2array(raw_data(73,'Run3'))];

% set beginnings and ends of sections in panel code
rbpc = [1; 1 + 33; 1 + 2*33];
repc = [33; 33*2; 33*3];

% load panel code predictions
for i = 1:3 
    str =['./output_data/deg' num2str(aoa(i))];
    for j = 1:3
        Cp_panel(i, rbpc(j):repc(j), :) = dlmread([str '/sect_00' num2str(j)]);
    end
end

Cp_panel(:, :, 2) = -Cp_panel(:, :, 2); % follow the same sign convention

% Cp_panel(a, b, c) syntax
% a - run index (1, 2 or 3)
% b - section index (use rbpc/repc)
% c - 1 for position along the chord, 2 for Cp (?)

% load tappings locations (as chord fractions)
tap_loc = load('tapping_locations.txt');
% rows 1-23: red section | 24-46: yellow section | 47-61: green section
% column 1: 0 deg | 2: 6 deg | 3: 14 deg run
% set row beginnings and ends for different sections
rb = [1; 27; 54];
re = [23; 49; 68];
% set row 'middles' - where tapping is at x/c = 0
rm = (rb+re)/2;
% copy pitot values
pitot_1 = [table2array(raw_data(71:72,'Run1')), table2array(raw_data(71:72,'Run2')), table2array(raw_data(71:72,'Run3'))];
pitot_2 = [table2array(raw_data(71:72,'Run1')), table2array(raw_data(71:72,'Run2')), table2array(raw_data(71:72,'Run3'))];

% set chord lengths at sections
span = [115; 300; 531];
c = -0.2167 * span + 255;
c = c/1000; % convert to metres

% calculate static, dynamic and stagnation pressures
% average is taken from two readings
for i = 1:3
    p_static(i) = 0.5 * (pitot_1(1,i) + pitot_2(1,i));
    p_stagn(i) = 0.5 * (pitot_1(2,i) + pitot_2(2,i));
    p_dyn(i) = 0.5 * ((pitot_1(2,i) - pitot_1(1,i)) + (pitot_2(2,i) - pitot_2(1,i)));
end

% calculate Cp
section_raw_data = [table2array(raw_data(:,'Run1')), table2array(raw_data(:,'Run2')), table2array(raw_data(:,'Run3'))];
for j = 1:3 
    for i = rb(1):re(3) 
       Cp(i,j) = (section_raw_data(i,j) - p_stagn(j)) / p_dyn(j);
    end
end

% setting limits for spline interpolation of results
rbs = [1; 1+202; 1+2*202];
rms = [102; 102+202; 102+2*202];
res = [202; 202*2; 202*3];

% interpolate readings taken during the lab
% using pchip - can be changed to spline
xx = 0:0.01:1;
for i = 1:3
    for j = 1:3 
        Cp_spline(i, rbs(j):(rms(j)-1)) = pchip(tap_loc(rb(j):rm(j)),Cp(rb(j):rm(j), i), xx);
        Cp_spline(i, rms(j):res(j)) = pchip(tap_loc(rm(j):re(j)),Cp(rm(j):re(j), i), xx);
    end
end

% extract averages for TE Cp
for i = 1:3 % run number
    for j = 1:3 % section number
        Cp_TE(i,j) = 0.5 * (Cp_spline(i, rms(j)-1) + Cp_spline(i, res(j)));
    end
end

Cp_TE = transpose(Cp_TE);

% add the TE data to the Cp matrix
tap_loc = [1; tap_loc(rb(1):re(1)); 1; 1; tap_loc(rb(2):re(2)); 1; 1; tap_loc(rb(3):re(3)); 1]; 
Cp = [Cp_TE(1, :); Cp(rb(1):re(1), :); Cp_TE(1, :); Cp_TE(2, :); Cp(rb(2):re(2), :); Cp_TE(2, :); Cp_TE(3, :); Cp(rb(3):re(3), :); Cp_TE(3, :)];
% change ranges for different sections
rb = [1; 26; 51];
re = [25; 50; 67];
rm = [13; 38; 59];

% interpolate once again, this time with averaged trailing edge values
for i = 1:3
    for j = 1:3 
        Cp_spline(i, rbs(j):(rms(j)-1)) = pchip(tap_loc(rb(j):rm(j)),Cp(rb(j):rm(j), i), xx);
        Cp_spline(i, rms(j):res(j)) = pchip(tap_loc(rm(j):re(j)),Cp(rm(j):re(j), i), xx);
    end
end

% set plotting style for Cp vs x/c graphs
crosses = {'xr', 'xy', 'xg'};
lines = {'-r', '-y', '-g'};

for fig = 1:3 % figure counter
    figure(fig)
    for j = 1:3
        subplot(1,3,j)
        plot(tap_loc(rb(j):re(j)), Cp(rb(j):re(j), fig), crosses{j});
        hold all
        plot(xx, Cp_spline(fig, rbs(j):(rms(j)-1)), lines{j});
        plot(xx, Cp_spline(fig, rms(j):res(j)), lines{j});
        plot(Cp_panel(fig, rbpc(j):repc(j), 1), Cp_panel(fig, rbpc(j):repc(j), 2), '-k');
    end    
end

% calculate sectional Cl
for i = 1:3 % run number
    for j = 1:3 % section number
        Cl(i,j) = - trapz(xx, Cp_spline(i, rbs(j):(rms(j)-1))) + trapz(xx, Cp_spline(i, rms(j):res(j)));
        Cl_panel(i,j) = trapz(Cp_panel(i, rbpc(j):repc(j), 1), Cp_panel(i, rbpc(j):repc(j), 2));
    end
end

% calculate theoretical prediction
% based on readings from Fig 19, Ref 3
% at 0 deg - Cl = 0.4667; at 4 deg - Cl = 0.9;
xx_t = 0:aoa(3);
Cl_theory = polyval([0.12 0.52], xx_t);

% set axes for Cl vs AoA plotting
cl_max = max(Cl_theory);
ax_cl = [0 aoa(3) 0 cl_max];

% set plotting style for Cl vs AoA plot
lines2 = {'-xr', '-xy', '-xg'};

% plot experimental results
fig = fig +1;
figure(fig)
hold on
plot(xx_t, Cl_theory, '-k');
for i = 1:3
   plot(aoa, Cl(:,i), lines2{i});
end
axis(ax_cl);
grid on;
title('Experimental C_L-\alpha variations of the three sections')
legend('infinite wing','root section', 'middle section', 'tip section','Location','southeast');
xlabel('$\mathrm{angle\:of\:attack\:(degrees)}$','Interpreter','latex');
ylabel('$\mathrm{lift\:coefficient}\:\:C_l$','Interpreter','latex');
saveas(gcf,'exp_cl','epsc')


% plot panel code results
fig = fig +1;
figure(fig)
hold on
plot(xx_t, Cl_theory, '-k');
for i = 1:3
    plot(aoa, Cl_panel(:,i), lines2{i});
end
axis(ax_cl);
grid on;
title('Panel code C_L-\alpha predictions of the three sections')
legend('infinite wing', 'root section', 'middle section', 'tip section','Location','southeast');
xlabel('$\mathrm{angle\:of\:attack\:(degrees)}$','Interpreter','latex');
ylabel('$\mathrm{lift\:coefficient}\:\:C_l$','Interpreter','latex');
saveas(gcf,'panel_Cl','epsc')

% calculate the percentage error in Cl prediction
disp('Below are listed relative Cl errors. Every row corresponds to a different run, every column corresponds to a different section.');
Cl_error = abs((Cl - Cl_panel)./(Cl))
% row - run number; column - section number

disp('Select the best prediction');
prompt = 'Input run number (row number): ';
run_best = input(prompt);
prompt = 'Input section number (column number) [1 - red; 2 - yellow; 3 - green]: ';
section_best = input(prompt);

disp('Select the worst prediction');
prompt = 'Input run number (row number): ';
run_worst = input(prompt);
prompt = 'Input section number (column number) [1 - red; 2 - yellow; 3 - green]: ';
section_worst = input(prompt);

ax_pred = [0, 1, -inf, inf];

% plot best prediction
fig = fig + 1;
figure(fig)
h1 = plot(tap_loc(rb(section_best):re(section_best)), -Cp(rb(section_best):re(section_best), run_best), 'xk');
hold all
h2 = plot(xx, -Cp_spline(run_best, rbs(section_best):(rms(section_best)-1)), '-k');
h3 = plot(xx, -Cp_spline(run_best, rms(section_best):res(section_best)), '-k');
h4 = plot(Cp_panel(run_best, rbpc(section_best):repc(section_best), 1), -Cp_panel(run_best, rbpc(section_best):repc(section_best), 2), '--b');
legend([h1 h2 h4], {'Experimental datapoints', 'Data fit', 'Panel code prediction'}, 'Location', 'Southeast');
xlabel('$\mathrm{position\:along\:the\:chord}$','Interpreter','latex');
ylabel('$\mathrm{pressure\:coefficient}\:\:-C_p$','Interpreter','latex');
title('Best panel code C_p prediction juxtaposed with experimental values');
axis ij;
saveas(gcf,'best_pred','epsc')

% plot worst prediction
fig = fig + 1;
figure(fig)
h1 = plot(tap_loc(rb(section_worst):re(section_worst)), -Cp(rb(section_worst):re(section_worst), run_worst), 'xk');
hold all
h2 = plot(xx, -Cp_spline(run_worst, rbs(section_worst):(rms(section_worst)-1)), '-k');
h3 = plot(xx, -Cp_spline(run_worst, rms(section_worst):res(section_worst)), '-k');
h4 = plot(Cp_panel(run_worst, rbpc(section_worst):repc(section_worst), 1), -Cp_panel(run_worst, rbpc(section_worst):repc(section_worst), 2), '--b');
legend([h1 h2 h4], {'Experimental datapoints', 'Data fit', 'Panel code prediction'}, 'Location', 'Southeast');
xlabel('$\mathrm{position\:along\:the\:chord}$','Interpreter','latex');
ylabel('$\mathrm{pressure\:coefficient}\:\:-C_p$','Interpreter','latex');
title('Worst panel code C_p prediction juxtaposed with experimental values');
axis ij;
saveas(gcf,'worst_pred','epsc')

% close all files
fclose('all');