% Parameters from Table 7
L = 1;
c = 2;
A = [1, 2, 3];
B = [-1, 0, 2, -1];

% Create mesh for plotting
x = linspace(0, L, 100);
t = linspace(0, 2, 100);
[T, X] = meshgrid(t, x);

% Initialize solution matrix
U = zeros(size(X));

% Compute solution for each point
for i = 1:length(x)
    for j = 1:length(t)
        U(i,j) = hyperbolic_analytical(x(i), t(j), L, c, A, B);
    end
end

% Create Figure 1: 2D Plot at different times
figure(1)
plot(x, U(:,1), 'b-', 'LineWidth', 2, 'DisplayName', 't = 0')
hold on
plot(x, U(:,25), 'r--', 'LineWidth', 2, 'DisplayName', 't = 0.5')
plot(x, U(:,50), 'g:', 'LineWidth', 2, 'DisplayName', 't = 1.0')
plot(x, U(:,75), 'm-.', 'LineWidth', 2, 'DisplayName', 't = 1.5')
plot(x, U(:,end), 'k--', 'LineWidth', 2, 'DisplayName', 't = 2.0')
hold off
grid on
xlabel('x')
ylabel('u(x,t)')
title('Wave Evolution at Different Times')
legend('Location', 'best')

% Create Figure 2: 3D Surface Plot
figure(2)
surf(T, X, U)
colormap('jet')
colorbar
xlabel('Time (t)')
ylabel('Position (x)')
zlabel('u(x,t)')
title('3D Visualization of Wave Solution')
shading interp

% Create Figure 3: Contour Plot
figure(3)
contourf(T, X, U, 20)
colormap('jet')
colorbar
xlabel('Time (t)')
ylabel('Position (x)')
title('Contour Plot of Wave Solution')