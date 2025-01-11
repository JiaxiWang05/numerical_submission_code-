% Test script to verify fdhyperbolic_neumann implementation

% Define test case
f = @(x)(sin(pi*x)+sin(2*pi*x));
g = @(x)(0*x);

% Run both implementations
[x_ref,t_ref,u_ref] = fdhyperbolic(0,1,10,0.5,20,2,f,g);
[x,t,u] = fdhyperbolic_neumann(0,1,10,0.5,20,2,f,g);

% Compare solutions
figure('Position', [100 100 800 600]);

% Initial Condition Comparison
subplot(2,1,1);
plot(x_ref, u_ref(:,1), 'b-', 'LineWidth', 2, 'DisplayName', 'Reference');
hold on;
plot(x, u(:,1), 'r--', 'LineWidth', 2, 'DisplayName', 'Our Solution');
title('Initial Condition Comparison');
xlabel('x');
ylabel('u(x,0)');
legend;
grid on;

% Final State Comparison
subplot(2,1,2);
plot(x_ref, u_ref(:,end), 'b-', 'LineWidth', 2, 'DisplayName', 'Reference');
hold on;
plot(x, u(:,end), 'r--', 'LineWidth', 2, 'DisplayName', 'Our Solution');
title('Final State Comparison');
xlabel('x');
ylabel('u(x,T)');
legend;
grid on;

% Print verification results
fprintf('\nVerification at key points:\n');
fprintf('At t=0:\n');
for i = 1:length(x)
    fprintf('x=%.1f: Reference=%.6f, Our=%.6f, Diff=%.2e\n', ...
            x(i), u_ref(i,1), u(i,1), abs(u_ref(i,1)-u(i,1)));
end

% Check time stepping formula
fprintf('\nChecking time stepping formula:\n');
fprintf('Time step 2 max error: %.2e\n', max(abs(u(:,2) - u_ref(:,2))));
fprintf('Time step 3 max error: %.2e\n', max(abs(u(:,3) - u_ref(:,3))));

% Verify numerical scheme parameters
h = (1-0)/10;
k = 0.5/20;
r = 2*k/h;
fprintf('\nNumerical scheme verification:\n');
fprintf('1. h = %.4f (should be 0.1000)\n', h);
fprintf('2. k = %.4f (should be 0.0250)\n', k);
fprintf('3. r = %.4f (should be 0.5000)\n', r);