% Error data from the table
polynomial_degrees = [1, 2, 3, 4, 5, 6, 7, 8];
errors_rule1 = [0, 0, 0, 0.178, 0, 0.212, 0, 0.198];
errors_rule2 = [0, 0, 0, 0, 0, 0.0457, 0, 0.0782];
errors_rule3 = [0, 0, 0, 0, 0, 0, 0, 0.012];

% Replace zeros with small values for log scale plotting
small_val = 1e-10;
errors_rule1(errors_rule1 == 0) = small_val;
errors_rule2(errors_rule2 == 0) = small_val;
errors_rule3(errors_rule3 == 0) = small_val;

% Create figure
figure('Position', [100, 100, 800, 600])

% Plot errors on a semilogarithmic scale
semilogy(polynomial_degrees, errors_rule1, 'ro-', 'LineWidth', 2, 'MarkerSize', 8);
hold on
semilogy(polynomial_degrees, errors_rule2, 'bs-', 'LineWidth', 2, 'MarkerSize', 8);
semilogy(polynomial_degrees, errors_rule3, 'gd-', 'LineWidth', 2, 'MarkerSize', 8);

% Add theoretical error bounds
n = [2, 3, 4]; % number of points for each rule
C = 1e-3; % constant for visualization
M = 2; % derivative-based constant
colors = [[1 0.5 0.5]; [0.5 0.5 1]; [0.5 1 0.5]]; % light shades for bounds

for i = 1:length(n)
    bound = C * M^(2 * n(i) + 2); % Theoretical bound for each rule
    semilogy(polynomial_degrees, bound * ones(size(polynomial_degrees)), '--', 'Color', colors(i, :), ...
             'LineWidth', 1.5, 'DisplayName', sprintf('Theoretical Bound Rule %d', i));
end

% Customize plot
grid on
xlabel('Polynomial Degree', 'FontSize', 12);
ylabel('Error (Log Scale)', 'FontSize', 12);
title('Gauss-Legendre Quadrature Error Convergence', 'FontSize', 14);
legend({'Rule 1 (2-point)', 'Rule 2 (3-point)', 'Rule 3 (4-point)', ...
        'Theoretical Bound Rule 1', 'Theoretical Bound Rule 2', 'Theoretical Bound Rule 3'}, ...
        'Location', 'southoutside', 'FontSize', 10);

% Set axis properties
xlim([1 8]);
ylim([1e-10 1]);
xticks(1:8);

% Add annotation for error bound formula
text(1.5, 1e-1, '$|E(f)| \leq C M^{(2n+2)}$', 'Interpreter', 'latex', ...
     'FontSize', 14, 'BackgroundColor', 'white');

hold off;
