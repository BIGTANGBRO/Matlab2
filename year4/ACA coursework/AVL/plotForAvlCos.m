%data processing for AVL
clear
clc

%nChord = [2]
nSpan = [10,15,20,50];

CL = [0.31183,0.31191,0.31189,0.31198];

CD = [0.0060756,0.0062116,0.0072918,0.0047122];

%nChord = [5]
nSpan1 = [10,15,20,50];

CL1 = [0.310,0.311,0.311,0.311];

CD1 = [0.00568,0.00588,0.00607,0.00260];

%nChord = [10]
nSpan2 = [10,15,20,50,100];

CL2 = [0.314,0.314,0.314,0.314,0.314];

CD2 = [0.00566,0.00569,0.00581,0.00442,0.00518];

%nChord = [15]
nSpan3 = [10,15,20,50,100,120];

CL3 = [0.313,0.314,0.314,0.314,0.314,0.314];

CD3 = [0.00562,0.00562,0.00574,0.00612,0.00490,0.00287];

%nChord = [20]
nSpan4 = [10,15,20,50,100,120];

CL4 = [0.313,0.314,0.314,0.314,0.314,0.314];

CD4 = [0.00560,0.00558,0.00570,0.00554,0.00546,0.00552];

figure(1)
plot(nSpan, CL);
hold on
plot(nSpan1,CL1,'*-');
hold on
plot(nSpan2,CL2);
hold on
plot(nSpan3, CL3,'o-');
hold on
plot(nSpan4, CL4);
title("CL vs span mesh number");
legend("2","5","10","15","20")
grid on
xlabel("Span mesh number");
ylabel("CL");
hold off;

figure(2)
plot(nSpan, CD);
hold on
plot(nSpan1,CD1,'*-');
hold on
plot(nSpan2,CD2);
hold on
plot(nSpan3, CD3,'o-');
hold on
plot(nSpan4, CD4);
legend("2","5","10","15","20")
grid on
xlabel("Span mesh number");
title("CDi vs span mesh number");
ylabel("CDi");
hold off;


