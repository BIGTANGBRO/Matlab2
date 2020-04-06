%use this script to calculate the marks

TotalPercentage = 9.29 + 4.65 + 6.19 +2.5+ 1.22 + 2.5 + 1.22 + 1.22 + 1.22 + 1.74 + 1.74 + 1.86;
Percentage = [9.29 ,4.65 ,6.19 ,2.5,1.22, 2.5, 1.22, 1.22, 1.22, 1.74, 1.74, 1.86]./TotalPercentage;

%Aero Math1 Prop CircularCylinder ProfileDrag Vibration ShearCenter StaticPre Static Polymer
%Sem NMCW1
Marks = [69;76;75;60;60;63.7;90;84;80;57;65;90];

Result = Percentage * Marks;
