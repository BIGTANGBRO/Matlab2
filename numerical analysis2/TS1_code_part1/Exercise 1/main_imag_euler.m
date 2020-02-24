function [ ] = main_imag_euler
% Call the function explicit Euler to solve the model problem with lambda
% purely imaginary 

f = @(t,x) 1i*x % Define the function f (in this case the model problem with imaginary lambda) 
tf = 25 % final time 
tspan = [0, tf] % define time span 
h = 0.1; 
y0 = 1; 
[t,y] = explicitEuler(f,tspan,y0,h)

 
figure(1) 
hold on 
box on 
grid on 
plot(t, y, 'bo--','MarkerSize',10)
xlabel('time (s)','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)
ylabel('y','interpreter', 'latex', 'fontsize', 20, 'Rotation', 0)

%% EXACT SOLUTION 
% The exact solution (known for the model problem) 
 y_sol = @(t) y0*exp(1i*t) % this is the exact solution of the problem 
 N = 500; 
 t_exact = linspace(0, tf, N); % creates a vector of N time instants 
                               % (uniformly spaced) 
 y_exact = y_sol(t_exact)      % Samples of the exact solution  
 
 % Plot exact solution (in blue) to compare with the numerical solution (in
 % red)
 
figure(1) 
plot(t_exact, y_exact, 'k','LineWidth',3)
set(gca,'FontSize',30)
end

