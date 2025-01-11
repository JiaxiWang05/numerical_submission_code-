 
function visualize_gauss_mechanism()
    % Create figure
    figure('Position', [100 100 600 400]);
    
    % Example polynomial x^2
    x = linspace(-1, 1, 100);
    f = @(x) x.^2;
    y = f(x);
    
    % Define Gauss points and weights for each rule
    gauss_rules = {
        {[0], [2]},                                  % 1-point rule
        {[-1/sqrt(3), 1/sqrt(3)], [1, 1]},          % 2-point rule
        {[-sqrt(0.6), 0, sqrt(0.6)], [5/9, 8/9, 5/9]} % 3-point rule
    };
    
    % Colors for each rule
    colors = {'r', 'g', 'b'};
    markers = {'o', 's', 'd'};
    
    % Plot function
    plot(x, y, 'k-', 'LineWidth', 1.5, 'DisplayName', 'f(x) = x^2');
    hold on;
    grid on;
    
    % Plot for each rule
    for i = 1:3
        % Get points and weights for this rule
        points = gauss_rules{i}{1};
        weights = gauss_rules{i}{2};
        
        % Plot points and weights
        for j = 1:length(points)
            point_y = f(points(j));
            % Plot points
            plot(points(j), point_y, [colors{i}, markers{i}], ...
                'MarkerSize', 10, ...
                'DisplayName', sprintf('%d-Point Rule (w=%.3f)', i, weights(j)));
            
            % Adjust vertical position for weight labels based on rule number
            if points(j) == 0  % For points at x=0
                text_y = point_y + 0.1 + 0.15*(i-1);  % Stagger heights for different rules
            else
                text_y = point_y + 0.1;
            end
            
            % Add weight labels with adjusted positions
            text(points(j), text_y, sprintf('w=%.3f', weights(j)), ...
                'HorizontalAlignment', 'center', ...
                'Color', colors{i});
        end
        
        % Calculate and display approximate integral
        approx = sum(weights .* f(points));
        text(-0.9, 1.1-0.1*i, sprintf('%d-Point Rule: %.4f', i, approx), ...
            'Color', colors{i});
    end
    
    % Add exact value
    exact = 2/3;
    text(-0.9, 1.1, sprintf('Exact: %.4f', exact), 'Color', 'k');
    
    % Labels and title
    xlabel('x');
    ylabel('f(x)');
    title('Gauss-Legendre Quadrature Points and Weights');
    legend('Location', 'best');
    axis([-1.2 1.2 -0.2 1.4]);  % Adjusted y-axis to accommodate staggered labels
end