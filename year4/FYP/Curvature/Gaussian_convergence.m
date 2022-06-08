clear
clc

gaussianAvgLoop = [42.2603 37.7565 36.5533 36.1876];
gaussianAvgMb = [42.2603 50.7308 54.7569 56.4056];
gaussianAvgR3 = [42.2603 39.1326 37.4648 36.9852];

hLoop1 = [0.0964, 0.046406, 0.02299,0.011466];
hMb1 =   [0.0964, 0.0485546, 0.024357,0.012195];
hRoot1 = [0.0964, 0.053957, 0.03057,0.01771];

hLoop = [5804,23216,92864,371456];
hMb = [5804,23217,92864,371456];
hRoot = [5804,17412,52236,156708];

plot(hLoop1, gaussianAvgLoop, '-*');
hold on
plot(hMb1, gaussianAvgMb, '-o');
hold on
plot(hRoot1, gaussianAvgR3, '->');
grid on

xlabel("Element size(No units)");
ylabel("Average Gaussian Curvature");
legend("Loop","Modified Butterfly","$\sqrt{3}$");