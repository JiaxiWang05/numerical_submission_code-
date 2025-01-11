% Test convergence of Neumann boundary condition
clear all; close all;

% Fixed parameters
a = 0; b = 1; T = 0.5; c = 2;
f = @(x) sin(pi*x/2);
g = @(x) (2*pi/2)*sin(pi*x/2);

% Different grid sizes to test
n_values = [100, 200, 400, 800];
errors = zeros(size(n_values));
h_values = (b-a)./n_values;

% Reference solution with very fine grid
n_ref = 3200;
[x_ref, t_ref, u_ref] = fdhyperbolic_neumann(a,b,n_ref,T,n_ref,c,f,g);

% Calculate errors for different grid sizes
for i = 1:length(n_values)
    n = n_values(i);
    [x, t, u] = fdhyperbolic_neumann(a,b,n,T,n,c,f,g);
    
    % Interpolate reference solution to current grid for comparison
    u_ref_interp = interp2(t_ref, x_ref, u_ref, t, x);
    
    % Calculate error at the boundary (rightmost point)
    errors(i) = max(abs(u(end,:) - u_ref_interp(end,:)));
end

% Calculate convergence rate
rates = log2(errors(1:end-1)./errors(2:end));

% Create convergence plot
figure;
loglog(h_values, errors, 'o-', 'LineWidth', 2);
hold on;
loglog(h_values, h_values.^2 * errors(1)/h_values(1)^2, '--', 'LineWidth', 1);
xlabel('Grid spacing (h)');
ylabel('Maximum error at boundary');
legend('Numerical error', 'O(h^2) reference', 'Location', 'northwest');
title('Convergence of Neumann Boundary Condition');
grid on;

% Display results in table format
fprintf('\nConvergence Analysis Results:\n');
fprintf('----------------------------------------\n');
fprintf('    h      Error    Rate\n');
fprintf('----------------------------------------\n');
for i = 1:length(n_values)
    if i == 1
        fprintf('%8.1e  %8.1e    -\n', h_values(i), errors(i));
    else
        fprintf('%8.1e  %8.1e  %5.2f\n', h_values(i), errors(i), rates(i-1));
    end
end