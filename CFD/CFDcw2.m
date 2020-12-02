clear
clc

%input
lamda = 1; %default value is 1
m = 3 ;
a = 0; %B.C.
b = 0; %B.C.
delta_x = [1/10, 1/20, 1/100, 1/100, 1/200, 1/1000]; %length of mesh interval

N = (1./delta_x)+1; %number of mesh points

for time = 1:length(delta_x)
    x = 0 : delta_x(time) : 1;
    b = (delta_x(time)^2)*(-((m*pi)^2) - lamda)*sin(m*pi*x(2:length(x) - 1));
    b = transpose(b);
    clear vars A
    A = zeros(N(time) - 2, N(time) - 2); %create a nil matrix for A
    for i = 1:N(time) - 2
        A(i,i) = -(2+lamda*(delta_x(time)^2));
    end
    for j = 1:N(time) - 3
        A(j,j+1) = 1;
        A(j+1,j) = 1;
    end
    %A(1:N(time) - 2,1:N(time) - 2) = -(2+lamda*(delta_x(time)^2));
    %A(1:N(time) - 3,2:N(time) - 2) = 1;
    %A(2:N(time) - 2,1:N(time) - 3) = 1;
    u(1:N(time) - 2,1) = 0;
    
    clear vars r
    eps = 1;
    n = 0; %iteration time
    while eps >= 10^(-7)
        n = n + 1;
        r(:,n) = b - A * u(:,n);
        eps = sqrt((1/N(time))*sum(r(:,n).^2));
        alpha = transpose(r(:,n))*(b - A*u(:,n))/(transpose(r(:,n))*A*r(:,n));
        u(:,n+1) = u(:,n) + alpha * r(:,n);
        
    end
    
    u = transpose(u(:,n)); 
    
    u_bar = sin(m*pi*x(2:length(x) - 1)); %exact solution
    
    error_max(time) = max(abs(u - u_bar));
    
    
    
    figure(time)
    plot(x(2:length(x)-1),u,'-r')
    hold on
    plot(x(2:length(x)-1),u_bar,'--b')
    hold off
    
end
