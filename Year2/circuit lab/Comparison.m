clc
clear

load('design_variable2.2.mat')
load('test_variable2.3.mat')

plot(DesignTime,DesignElevator);
hold on
plot(TestTime,TestElevator);
xlabel("time");
ylabel("Elevator");
legend("Low fidelity","high fidelity");
hold off

plot(DesignTime,DesignPitchAngle);
hold on
plot(TestTime,TestPitchAngle);
xlabel("time");
ylabel("Pitch Angle");
legend("Low fidelity","high fidelity");
hold off

plot(DesignTime,DesignPitchRate);
hold on
plot(TestTime,TestPitchRate);
xlabel("time");
ylabel("Pitch Rate");
legend("Low fidelity","high fidelity");
hold off