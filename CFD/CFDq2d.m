%Question2
clc
clear

deltaX = [1/10,1/20,1/50,1/100,1/200,1/500];
maxErrorMatrix = zeros(length(deltaX),1);

%for each dx
for dx = 1:length(deltaX)
deltaT = 2*10^(-5);
sig = 4;
T = 0.05;
%number of mesh points
N = 1./deltaX(dx) + 1;

%clear the values
clear vars x t u uValues
clear vars beta gamma uNum uSingle uAll betaN maxError uInitial

%x and t points
x = [0:deltaX(dx):1];
t = [0:deltaT:T];

%initial conditions
for m = 0:50
    u(:,m+1) = (-1)^m * 40 /((2 * m + 1).^2*pi.^2).*sin((2 * m + 1)*pi.*x);
end
for i=1:length(x)
    uValues(:,i) = sum(u(i,:));
end
%save the initial conditions
uInitial(:,:) = uValues(:,:);

%Thomas algorithms
k = sig*deltaT/deltaX(dx)^2;
a = ones(N-1,1)*(-k);
a(1)=0;
a(N-1) = -1;
b = ones(N-1,1)*(1+2*k);
b(N-1,1) = 1;
c = ones(N-1,1)*(-k);
c(N-1)=0;

%starts from n=2, n-1 is the initial condition for n=2 here.
for i = 2:length(t)
    for m = 0:1:50
        uSingle(m+1,:) = (((-1)^m) * 40 / ((2 * m + 1)^2*pi^2)).*sin((2 * m + 1)*pi.*x).*exp(-sig*(2*m + 1)^2*pi^2*t(i));
    end
    %for each t
    uAll(i-1,:) = sum(uSingle,1);
    
    %Derichlet
    alphaD = 0;
    %neumann
    betaN = 0;
    %du/dx to calculate Neumann
    for m = 0:1:50
        betaN = betaN + (-1)^(m+1)*40/((2*m+1)*pi)*exp(-sig*(2*m+1)^2*pi^2*t(i));
    end
    
    uValues(i-1,N) = deltaX(dx)*betaN;
    
    %forward
    beta(i-1,1) = b(1);
    %for u starts from the first row
    gamma(i-1,1) = uValues(i-1,2)/beta(i-1,1);
    for k = 2:N-1
        beta(i-1,k) = b(k)-a(k)*c(k-1)/beta(i-1,k-1);
        gamma(i-1,k) = (-a(k)*gamma(i-1,k-1)+uValues(i-1,k+1))/beta(i-1,k);
    end
    
    %backward
    uNum(i-1,N-1) = gamma(i-1,N-1); 
    for j = N-2:-1:1
        uNum(i-1,j) = gamma(i-1,j)-(uNum(i-1,j+1)*c(j))/beta(i-1,j);
    end 
    uValues(i,:) = [0,uNum(i-1,:)];
end
uNum = [zeros(length(t)-1,1),uNum];
uNum = [uInitial;uNum];
uAll = [uInitial;uAll];
%calculate the maximum error
maxError = 0;    
% %2d matrix method1
% for row = 1:length(uNum(:,1))
%     for col = 1:length(uNum(1,:))
%         if abs(uNum(row,col)-uAll(row,col)) > maxError
%             maxError = abs(uNum(row,col)-uAll(row,col));
%         end
%     end
% end

%method 2
maxError = max(abs(uNum(length(t),:)-uAll(length(t),:)));
maxErrorMatrix(dx) = maxError;

end

plot(log10(deltaX),log10(maxErrorMatrix));
grid on
title("Plot of maximum error");
ylabel('log(Maximum error)');
xlabel('log(deltaX)');
hold off