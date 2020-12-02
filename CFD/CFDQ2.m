%Question2
clc
clear

%initial conditions
t=0;
x = [0:0.01:1];
for m = 0:50
    u(:,m+1) = (-1).^m.*40/((2.*m+1).^2.*pi.^2)*sin((2.*m+1).*pi.*x);
end
for i=1:length(x)
    uValues(i) = sum(u(i,:));
end
%plot the initial conditions
plot(x,uValues);
grid on
xlabel('x');
ylabel('u');
title('Initial Conditions');




