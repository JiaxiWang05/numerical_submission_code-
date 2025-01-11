% Verification for the specific example
clear all; close all;

% Example parameters
a = 0; b = 1;
n = 10; m = 20;
T = 0.5; c = 2;
f = @(x)(sin(pi*x)+sin(2*pi*x));
g = @(x)(0*x);

% Run both implementations
[x1,t1,u1] = fdhyperbolic(a,b,n,T,m,c,f,g);         % Reference solution
[x2,t2,u2] = fdhyperbolic_neumann(a,b,n,T,m,c,f,g); % Our solution

% Check specific points from the example
fprintf('Verification at key points:\n');
fprintf('At t=0:\n');
for i = 1:length(x1)
    fprintf('x=%.1f: Reference=%.6f, Our=%.6f, Diff=%.2e\n', ...
        x1(i), u1(i,1), u2(i,1), abs(u1(i,1)-u2(i,1)));
end

% Calculate numerical parameters
h = (b-a)/n;
k = T/m;
r = c*k/h;

% Check time evolution formula
fprintf('\nChecking time stepping formula:\n');
for j = 2:3  % Check first few time steps
    interior_diff = u2(2:n,j+1) - ((2-2*r^2)*u2(2:n,j) + ...
        r^2*(u2(3:n+1,j) + u2(1:n-1,j)) - u2(2:n,j-1));
    fprintf('Time step %d max error: %.2e\n', j, max(abs(interior_diff)));
end

% Plot comparison
figure('Position', [100 100 800 600]);
subplot(2,1,1)
plot(x1, u1(:,1), 'b-', x1, u2(:,1), 'r--', 'LineWidth', 2)
title('Initial Condition Comparison')
legend('Reference', 'Our Solution')
grid on

subplot(2,1,2)
plot(x1, u1(:,end), 'b-', x1, u2(:,end), 'r--', 'LineWidth', 2)
title('Final State Comparison')
legend('Reference', 'Our Solution')
grid on

% Check if formula is correctly implemented
h = (b-a)/n;
k = T/m;
r = c*k/h;
fprintf('\nNumerical scheme verification:\n');
fprintf('1. h = %.4f (should be 0.1000)\n', h);
fprintf('2. k = %.4f (should be 0.0250)\n', k);
fprintf('3. r = %.4f (should be 0.5000)\n', r);

% Verify time stepping formula at a specific point
mid_point = n/2;
time_step = 10;
expected = (2-2*r^2)*u2(mid_point,time_step) + ...
    r^2*(u2(mid_point+1,time_step) + u2(mid_point-1,time_step)) - ...
    u2(mid_point,time_step-1);
actual = u2(mid_point,time_step+1);
fprintf('4. Time stepping error at x=0.5, t=%.2f: %.2e\n', ...
    t2(time_step), abs(expected-actual));