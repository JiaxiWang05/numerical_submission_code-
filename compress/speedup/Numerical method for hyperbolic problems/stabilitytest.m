% Stability test for fdhyperbolic_neumann
clear all; close all;

% Test parameters
a = 0; b = 1;
n = 10;
c = 2;
f = @(x)(sin(pi*x)+sin(2*pi*x));
g = @(x)(0*x);

% Test different time periods
T_values = [0.5, 1.0, 2.0, 5.0];
m_values = [20, 40, 80, 200];  % Keeping same dt ratio

% Store maximum values for stability check
max_values = zeros(length(T_values), 1);

figure('Position', [100 100 800 600]);

for i = 1:length(T_values)
    T = T_values(i);
    m = m_values(i);
    
    % Compute solution
    [x,t,u] = fdhyperbolic_neumann(a,b,n,T,m,c,f,g);
    
    % Store maximum value
    max_values(i) = max(max(abs(u)));
    
    % Plot solution at final time
    subplot(2,2,i)
    plot(x, u(:,end), 'b-', 'LineWidth', 2)
    title(sprintf('T = %.1f', T))
    xlabel('x')
    ylabel('u(x,T)')
    grid on
end

% Check if solution remains bounded
fprintf('Stability Analysis:\n');
fprintf('Time   Max|u|    Growth\n');
fprintf('----------------------\n');
for i = 1:length(T_values)
    if i == 1
        growth = 1;
    else
        growth = max_values(i)/max_values(1);
    end
    fprintf('%.1f    %.4f   %.4f\n', T_values(i), max_values(i), growth);
end

% Check CFL condition
h = (b-a)/n;
k = T_values(1)/m_values(1);  % Same for all cases
CFL = c*k/h;
fprintf('\nCFL number = %.4f (should be ≤ 1)\n', CFL);