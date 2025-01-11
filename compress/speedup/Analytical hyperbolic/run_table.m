% Set parameters from Table 7
L = 1;
c = 2;
A = [1, 2, 3];
B = [-1, 0, 2, -1];

% Define points from Table 6
x_values = [0.2; 0.5; 0.9];
t_values = [0; 1; 2];

% Initialize results matrix
results = zeros(length(x_values) * length(t_values), 1);
k = 1;

% Compute solutions for all points
for ti = t_values'
    for xi = x_values'
        results(k) = hyperbolic_analytical(xi, ti, L, c, A, B);
        k = k + 1;
    end
end

% Create arrays for table display
t_col = repelem(t_values, length(x_values));
x_col = repmat(x_values, length(t_values), 1);

% Display results in a formatted way
fprintf('\nTable 6: Values of the solution of the hyperbolic problem\n\n');
fprintf('   t     x          u\n');
fprintf('------------------------\n');
for i = 1:length(results)
    fprintf('%4.1f  %4.1f  %10.6f\n', t_col(i), x_col(i), results(i));
end