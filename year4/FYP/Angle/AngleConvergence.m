clear
clc

dihedralLoop = [162.3821, 172.2905,176.2460, 178.1311];
dihedralMB = [162.3821, 168.6832, 173.5270, 176.5374 ];
dihedralRoot = [162.3821, 169.7331, 174.8686, 176.7488];

hLoop = [5804,23216,92864,371456];
hMb = [5804,23217,92864,371456];
hRoot = [5804,17412,52236,156708];

plot(hLoop,dihedralLoop, '-*');
hold on
plot(hMb, dihedralMB,'-o');
hold on
plot(hRoot, dihedralRoot,'->');
grid on
xlabel("Number of Triangles");
ylabel("Average Dihedral Angles");
legend("Loop","Modified Butterfly","$\sqrt{3}$");