%data processing for AVL

%nChord = [10]
nSpan = [10,25,50,100,150,180];

CL = [0.31939, 0.31482,0.31315,0.31230,0.3121,0.31190];

CD = [0.0053423, 0.0053605,0.0053287,0.0052800,0.0059123,0.0058234];

%nChord = [15]
nSpan1 = [10,25,50,100,150];

CL1 = [0.32042,0.31585,0.31419,0.31334,0.31303];

CD1 = [0.0053837,0.0054012,0.0053883,0.0054243,0.0057299];

%nChord = [20]
nSpan2 = [10,25,50,100,150];

CL2 = [0.32125,0.31667,0.31501,0.31414,0.31385];

CD2 = [0.0054146,0.0054315,0.0054232,0.0054418,0.0055880];

%nChord = [30]
nSpan3 = [50,100];

CL3 = [0.31577,0.31492];

CD3 = [0.0054596,0.0054573];

figure(1)
plot(nSpan, CL);
hold on
plot(nSpan1,CL1);
hold on
plot(nSpan2,CL2);
hold on
plot(nSpan3, CL3);
title("CL vs span mesh number");
legend("10","15","20","30")
grid on
xlabel("Span mesh number");
ylabel("CL");
hold off;

figure(2)
plot(nSpan, CD);
hold on
plot(nSpan1,CD1);
hold on
plot(nSpan2,CD2);
hold on
plot(nSpan3, CD3);
legend("10","15","20","30")
grid on
xlabel("Span mesh number");
title("CDi vs span mesh number");
ylabel("CDi");
hold off;


