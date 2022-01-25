%plot for the star ccm+ mesh refinement study
%base size = [1, 0.5, 0.2,0.1, 0.01,0.005];
% 0.01:8764; 0.005:14755
%angle of attack 2

number = [3051,3440,3529,3620,8755,14733];
size = [1, 0.5, 0.2, 0.1, 0.01, 0.005];
cl = [0.4746, 0.5536, 0.5480, 0.5031, 0.4346, 0.4315];
cd = [0.01928, 0.01898, 0.01877, 0.01822, 0.01624, 0.01598];

yyaxis left
plot(number,cl,'*-');
ylabel("CL");
hold on
yyaxis right
plot(number,cd,'.-');
ylabel("CD")
grid on
xlabel("Cell number");
legend("Lift coefficient","Drag coefficient");
