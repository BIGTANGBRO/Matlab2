clear
clc

%inputs
delta_x = 1/500;
delta_t = 2*(10)^(-5);
tao = 4;
T = 0.05;
N = (1/delta_x)+1;

K=tao*delta_t/(delta_x^2);
%calculate the initial condition
x = [0:delta_x:1];

for m = 0:1:50
    u_m(m+1,:) = (((-1)^m) * 40 / (((2 * m + 1)*pi)^2)) * (sin((2 * m + 1)*pi.*x));
end

u(1,:) = sum(u_m,1);

u_real(1,:) = u(1,:);

%loop for time
time = 1; %number of iteration of time
for t = delta_t:delta_t:T
    time = time + 1;
    %the exact solution
    for m = 0:1:50
        u_m_e(m+1,:) = (((-1)^m) * 40 / (((2 * m + 1)*pi)^2)) * (sin((2 * m + 1)*pi.*x))*(exp(-tao*(((2*m + 1)*pi)^2)*t));
    end

    u_real(time,:) =  sum(u_m_e,1);
    alpha = 0; %Dirichlet condition at x = 0
    beta = 0; %Dirichlet condition at x = 1
    for m = 0:1:50
        beta = beta + (((-1)^m) * 40 / (((2 * m + 1)*pi))) * (cos((2 * m + 1)*pi))*(exp(-tao*(((2*m + 1)*pi)^2)*t));
    end
    
    %Generate matrix A
    A = zeros( N - 1, N - 1); %create a nil matrix
    for i = 1:N - 1
        A(i,i) = -(2+((delta_x^2)/(tao*delta_t)));
    end
    for j = 1:N - 2
        A(j,j+1) = 1;
        A(j+1,j) = 1;
    end
    %substitute two values a Neumann condition at x = 1
    A(N - 1, N - 1) = 1;
    A(N - 1, N - 2) = -1;
    
    %Generate matrix of f
    f = u(time-1,2:N);
    %substitute the first and last term in f
    f(1)=f(1) - alpha;
    f(N - 1) = delta_x*beta;
    
    %applying Thomas algorithm
    %create matrix for a,b,c
    a(1:N-1) = -K;
    a(N-1) = -1;
    a(1) = 0;
    b(1:N-1) = 1+2*K;
    b(N-1) = 1;
    c(1:N-1) = -K;
    c(N-1) = 0;
    
    %forward step
    beta_thomas(time-1,1) = b(1);
    gama(time-1,1) = f(1)/beta_thomas(time-1,1);
    for i_f = 2: N - 1
        beta_thomas(time-1,i_f) = b(i_f) - (a(i_f)*c(i_f-1)/beta_thomas(time-1,i_f-1));
        gama(time-1,i_f) = ((-a(i_f)*gama(time-1,i_f-1)) + f(i_f))/beta_thomas(time-1,i_f);
    end
    
    %backward step
    u(time,:) = zeros(1,N);
    u(time,N) = gama(time-1,N-1);
    for i_b = N-2:-1:1
        u(time,i_b+1) = gama(time-1,i_b) - (u(time,i_b + 2)*c(i_b)/beta_thomas(time-1,i_b));%numerical solution
    end
    %if time == 2
        %break
    %end
end

for k = 1:(T/delta_t)+1
    plot(x,u(k,:))
    hold on
end
