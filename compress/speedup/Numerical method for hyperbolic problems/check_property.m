% Verification script for fdhyperbolic_neumann
clear all; close all;

% Test case parameters
a = 0; b = 1;
n = 100; % Using finer grid for better accuracy
m = 200;
T = 0.5;
c = 2;
f = @(x)(sin(pi*x)+sin(2*pi*x));
g = @(x)(0*x);

% Compute numerical solution
[x,t,u_num] = fdhyperbolic_neumann(a,b,n,T,m,c,f,g);

% Verification checks
fprintf('Verification Tests:\n');

% 1. Check if left boundary condition (u(0,t) = 0) is satisfied
fprintf('1. Left BC (should be ≈0): max|u(0,t)| = %.2e\n', max(abs(u_num(1,:))));

% 2. Check if right Neumann BC (du/dx(1,t) = 0) is satisfied
h = (b-a)/n;
right_derivative = (u_num(end,:) - u_num(end-1,:))/h;
fprintf('2. Right BC (should be ≈0): max|du/dx(1,t)| = %.2e\n', max(abs(right_derivative)));

% 3. Check if initial condition is satisfied
initial_error = max(abs(u_num(:,1) - f(x)));
fprintf('3. Initial condition error: %.2e\n', initial_error);

% 4. Check CFL condition
k = T/m;
CFL = c*k/h;
fprintf('4. CFL number (should be ≤1): %.3f\n', CFL);


% 5. Plot solution
figure;
subplot(2,1,1)
plot(x, u_num(:,1), 'b-', 'LineWidth', 2)
hold on
plot(x, f(x), 'r--', 'LineWidth', 2)
title('Initial Condition Comparison')
legend('Numerical', 'Exact')
grid on

subplot(2,1,2)
[X,T] = meshgrid(t,x);
surf(T,X,u_num)
title('Solution Evolution')
xlabel('Time')
ylabel('Space')
zlabel('u(x,t)')