%plot for the star ccm+ mesh refinement study
%base size = [1, 0.5, 0.2,0.1, 0.05, 0.01, 0.006,0.005];
%element number = [3051, 3440,3529, 3620,4086, 8755,12701, 14733]

size = [1, 0.5,0.2, 0.1,0.01, 0.005];
cl = [2.761E-1,3.53E-1, 3.485E-1 ,3.023E-1, 2.507E-1,2.501E-1];
cd = [6.1373E-2,5.5495E-2, 5.41E-2 ,5.128E-2,3.873E-2,3.74E-2];

yyaxis left
plot(size,cl,'*-');
ylabel("CL");
hold on
yyaxis right
plot(size,cd,'.-');
ylabel("CD")
grid on
xlabel("Base mesh size/m");
legend("Lift coefficient","Drag coefficient");
