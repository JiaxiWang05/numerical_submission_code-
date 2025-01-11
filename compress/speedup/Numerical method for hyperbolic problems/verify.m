% Test script for fdhyperbolic_neumann
clear all; close all;

% Define parameters as given in the example
a = 0; b = 1;           % Domain [0,1]
T = 0.5;               % Final time
n = 10;                % Number of spatial intervals
m = 20;                % Number of time steps
c = 2;                 % Wave speed

% Define initial conditions as specified
f = @(x)(sin(pi*x)+sin(2*pi*x));
g = @(x)(0*x);

% Compute solution using fdhyperbolic_neumann
[x,t,u] = fdhyperbolic_neumann(a,b,n,T,m,c,f,g);

% Create visualizations
figure('Position', [100 100 1200 400]);

% Plot 1: Solution surface
subplot(1,3,1)
surf(t,x,u)
title('Wave Solution')
xlabel('Time (t)')
ylabel('Position (x)')
zlabel('u(x,t)')
colorbar

% Plot 2: Wave profiles at different times
subplot(1,3,2)
plot(x, u(:,1), 'b-', 'LineWidth', 2, 'DisplayName', 't = 0')
hold on
plot(x, u(:,end), 'r--', 'LineWidth', 2, 'DisplayName', 't = T')
title('Wave Profiles')
xlabel('x')
ylabel('u')
legend('Location', 'best')
grid on

% Plot 3: Time evolution at specific points
subplot(1,3,3)
plot(t, u(n/2,:), 'b-', 'LineWidth', 2)
title('Time Evolution at x = 0.5')
xlabel('t')
ylabel('u')
grid on

% Print numerical parameters
fprintf('Numerical Parameters:\n');
fprintf('h = %.4f (spatial step)\n', (b-a)/n);
fprintf('k = %.4f (time step)\n', T/m);
fprintf('CFL number = %.4f\n', c*T/(m*(b-a)/n));