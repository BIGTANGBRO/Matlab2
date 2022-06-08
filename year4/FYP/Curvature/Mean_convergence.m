clear
clc

meanAvgLoop = [10.0910 9.3357 9.0874 9.0387];
meanAvgMb =   [10.0910 14.0790 15.9670 16.4460];
meanAvgR3 =   [10.0910 11.0102 9.2868 9.4532];
%meanAvgR3 = [10.0910 11.0102 9.2868 10.4532]

hLoop1 = [0.0964, 0.046406, 0.02299,0.011466];
hMb1 =   [0.0964, 0.0485546, 0.024357,0.012195];
hRoot1 = [0.0964, 0.053957, 0.03057,0.01771];

hLoop = [5804,23216,92864,371456];
hMb =   [5804,23217,92864,371456];
hRoot = [5804,17412,52236,156708];

plot(hLoop1, meanAvgLoop, '-*');
hold on
plot(hMb1, meanAvgMb, '-o');
hold on
plot(hRoot1, meanAvgR3, '->');
grid on

xlabel("Element size(No units)");
ylabel("Average Mean Curvature");
legend("Loop","Modified Butterfly","$\sqrt{3}$");