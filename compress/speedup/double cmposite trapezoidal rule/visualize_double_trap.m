 function visualize_test_functions()
    % Define the three test functions
    f1 = @(x,y) ones(size(x));           % f(x,y) = 1
    f2 = @(x,y) x.*y;                    % f(x,y) = xy
    f3 = @(x,y) sin(pi*x).*sin(pi*y);    % f(x,y) = sin(πx)sin(πy)
    
    % Create grid for plotting
    [X, Y] = meshgrid(linspace(0,1,50));
    
    % Create figure
    figure('Position', [100 100 1200 400]);
    
    % Plot f1
    subplot(1,3,1);
    surf(X, Y, f1(X,Y));
    title('f(x,y) = 1');
    xlabel('x'); ylabel('y'); zlabel('f(x,y)');
    colorbar;
    
    % Plot f2
    subplot(1,3,2);
    surf(X, Y, f2(X,Y));
    title('f(x,y) = xy');
    xlabel('x'); ylabel('y'); zlabel('f(x,y)');
    colorbar;
    
    % Plot f3
    subplot(1,3,3);
    surf(X, Y, f3(X,Y));
    title('f(x,y) = sin(πx)sin(πy)');
    xlabel('x'); ylabel('y'); zlabel('f(x,y)');
    colorbar;
    
    % Save figure
    saveas(gcf, 'test_functions.png');
end