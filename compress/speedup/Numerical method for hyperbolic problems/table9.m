 % Parameters from Table 9
a = 0;          % Left boundary
b = 1;          % Right boundary
L = 1;          % Domain length
n = 1000;       % Number of spatial points
m = 1000;       % Number of time points
c = 2;          % Wave speed
T = 0.5;        % Final time

% Define initial conditions from Table 9
f = @(x) sin(pi*x/2);           % Initial position
g = @(x) (2*pi/2)*sin(pi*x/2);  % Initial velocity

% Points to evaluate from Table 8
x_eval = [0.2; 0.5; 0.9];
t_eval = [0; 0.05; 0.5];

% Run numerical solution
[x, t, u_num] = fdhyperbolic_neumann(a,b,n,T,m,c,f,g);

% For analytical solution
% For f(x) = sin(πx/2) and g(x) = π*sin(πx/2)
A = [1];        % Coefficient for initial position
B = [2];  % Coefficient for initial velocity

% Initialize results table
fprintf('t      x      u_ref         u            u_err\n');
fprintf('------------------------------------------------\n');

% Create a figure with 3 subplots
figure('Position', [50 50 1400 500])

% 1. Surface plot (3D visualization)
subplot(1,3,1)
[T_mesh, X_mesh] = meshgrid(t, x);
surf(T_mesh, X_mesh, u_num)
colormap('jet')
colorbar
xlabel('Time (t)')
ylabel('Position (x)')
zlabel('Wave amplitude (u)')
title('3D Wave Evolution')
shading interp
lighting gouraud
camlight

% 2. Spatial evolution at different times
subplot(1,3,2)
plot(x, u_num(:,1), 'b-', 'LineWidth', 1.5, 'DisplayName', 't = 0')
hold on
plot(x, u_num(:,round(m/4)), 'r--', 'LineWidth', 1.5, 'DisplayName', sprintf('t = %.2f', T/4))
plot(x, u_num(:,end), 'g:', 'LineWidth', 1.5, 'DisplayName', sprintf('t = %.2f', T))
hold off
xlabel('Position (x)')
ylabel('Wave amplitude (u)')
title('Wave Evolution in Space')
grid on
legend('Location', 'best')

% 3. Time evolution at specific points
subplot(1,3,3)
x_points = [0.2, 0.5, 0.9];
colors = {'b-', 'r--', 'g:'};
hold on
for i = 1:length(x_points)
    [~, x_idx] = min(abs(x - x_points(i)));
    plot(t, u_num(x_idx,:), colors{i}, 'LineWidth', 1.5, ...
         'DisplayName', sprintf('x = %.1f', x_points(i)))
end
hold off
xlabel('Time (t)')
ylabel('Wave amplitude (u)')
title('Wave Evolution in Time')
grid on
legend('Location', 'best')

% Create an animated visualization in a new figure
figure('Position', [50 600 800 400])
for i = 1:10:m+1  % Skip frames for smoother animation
    plot(x, u_num(:,i), 'b-', 'LineWidth', 2)
    hold on
    plot(x, u_num(:,i), 'ro', 'MarkerSize', 3)
    hold off
    xlabel('Position (x)')
    ylabel('Wave amplitude (u)')
    title(sprintf('Wave Propagation at t = %.3f', t(i)))
    grid on
    ylim([min(u_num(:))-0.1, max(u_num(:))+0.1])
    drawnow
end

for ti = 1:length(t_eval)
    for xi = 1:length(x_eval)
        % Get numerical solution at closest grid point
        [~, t_idx] = min(abs(t - t_eval(ti)));
        [~, x_idx] = min(abs(x - x_eval(xi)));
        u_numerical = u_num(x_idx, t_idx);
        
        % Get analytical solution
        u_analytical = hyperbolic_analytical(x_eval(xi), t_eval(ti), L, c, A, B);
        
        % Compute error
        error = abs(u_numerical - u_analytical);
        
        % Print results
        fprintf('%.2f   %.1f   %.6f   %.6f   %.6f\n', ...
                t_eval(ti), x_eval(xi), u_analytical, u_numerical, error);
    end
end