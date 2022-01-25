%data processing for AVL
clear
clc

%nChord = [2]
nSpan = [10,15,20,50,80];

CL = [0.322,0.320,0.318,0.316,0.315];

CD = [0.00535,0.00536,0.00535,0.00499,0.00465];

%nChord = [5]
nSpan1 = [10,15,20,50,100,150];

CL1 = [0.316,0.316,0.315,0.312,0.311,0.311];

CD1 = [0.00529,0.00531,0.00531,0.00517,0.00535,0.00579];

%nChord = [10]
nSpan2 = [10,15,20,50,100,120,150];

CL2 = [0.320,0.317,0.316,0.313,0.312,0.312,0.312];

CD2 = [0.00534,0.00535,0.00536,0.00533,0.00528,0.00556,0.00591];

%nChord = [15]
nSpan3 = [10,15,20,50,100,120,150];

CL3 = [0.320,0.320,0.317,0.314,0.313,0.313,0.313];

CD3 = [0.00539,0.00540,0.00540,0.00539,0.00541,0.00560,0.00542];

%nChord = [16]
nSpan4 = [10,15,20,50,100,120,150];

CL4 = [0.321,0.318,0.317,0.314,0.313,0.313,0.313];

CD4 = [0.00539,0.005400,0.00540,0.00540,0.00540,0.005502,0.00540];

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
legend("2","5","10","15","16")
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
legend("2","5","10","15","16")
grid on
xlabel("Span mesh number");
title("CDi vs span mesh number");
ylabel("CDi");
hold off;


