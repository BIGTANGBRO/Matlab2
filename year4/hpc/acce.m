clear
clc

threads = [1,2,4,8,16,32];
bCase = [4061.74, 1994.258, 1030.802, 1394.751,  3300, 2288.299];
dCase = [372.200, 192.467, 145.498, 146.407, 188.589, 245.892];

plot(threads, bCase, '-*');
hold on
plot(threads, dCase, '-*');
ylabel("Execution time/s");
xlabel("Number of threads");
legend("b case", "d case");
grid on