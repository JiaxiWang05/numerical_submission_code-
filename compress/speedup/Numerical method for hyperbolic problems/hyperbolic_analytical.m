function u = hyperbolic_analytical(x, t, L, c, A, B)
%HYPERBOLIC_ANALYTICAL Compute analytical solution of wave equation
%   u = HYPERBOLIC_ANALYTICAL(x, t, L, c, A, B) computes the solution of the
%   wave equation u_tt = c^2 * u_xx at point (x,t) with:
%   - Boundary conditions: u(0,t) = 0, u_x(L,t) = 0
%   - Initial conditions: u(x,0) = f(x), u_t(x,0) = g(x)
%
%   Inputs:
%       x - Spatial coordinate (0 <= x <= L)
%       t - Time coordinate (t >= 0)
%       L - Domain length (L > 0)
%       c - Wave speed coefficient
%       A - Coefficients for f(x) expansion
%       B - Coefficients for g(x) expansion
%
%   Output:
%       u - Solution value at point (x,t)
%
%   Example:
%       x = 0.5; t = 1; L = 1; c = 2;
%       A = [1, 2, 3]; B = [-1, 0, 2, -1];
%       u = hyperbolic_analytical(x, t, L, c, A, B)
%
%   See also: SIN, COS, SUM

    % Input validation
    validateattributes(x, {'numeric'}, {'scalar', '>=', 0, '<=', L}, ...
        'hyperbolic_analytical', 'x');
    validateattributes(t, {'numeric'}, {'scalar', '>=', 0}, ...
        'hyperbolic_analytical', 't');
    validateattributes(L, {'numeric'}, {'scalar', '>', 0}, ...
        'hyperbolic_analytical', 'L');
    validateattributes(c, {'numeric'}, {'scalar'}, ...
        'hyperbolic_analytical', 'c');
    validateattributes(A, {'numeric'}, {'vector'}, ...
        'hyperbolic_analytical', 'A');
    validateattributes(B, {'numeric'}, {'vector'}, ...
        'hyperbolic_analytical', 'B');

    % Convert input vectors to column vectors
    A = A(:);
    B = B(:);

    % Determine number of terms in series
    n_max = max(length(A), length(B)) - 1;
    
    % Create index vector for computations
    n_vector = (0:n_max)';
    
    % Precompute common terms
    lambda_n = (2*n_vector + 1) * (pi/(2*L));
    
    % Precompute trigonometric terms
    sin_x = sin(lambda_n * x);
    cos_t = cos(c * lambda_n * t);
    sin_t = sin(c * lambda_n * t);
    
    % Pad coefficient vectors with zeros
    A_padded = zeros(n_max + 1, 1);
    B_padded = zeros(n_max + 1, 1);
    
    A_padded(1:length(A)) = A;
    B_padded(1:length(B)) = B/c;
    
    % Compute solution using vectorized operations
    u = sum(sin_x .* (A_padded .* cos_t + B_padded .* sin_t));
end

% Improved version with interpolation
function u_numerical = get_interpolated_solution(t, x, u_num, t_eval, x_eval)
    % 2D interpolation for better accuracy
    [T, X] = meshgrid(t, x);
    u_numerical = interp2(T, X, u_num, t_eval, x_eval, 'spline');
    
    % Error estimation for interpolation
    [~, t_idx] = min(abs(t - t_eval));
    [~, x_idx] = min(abs(x - x_eval));
    u_nearest = u_num(x_idx, t_idx);
    interp_error = abs(u_numerical - u_nearest);
    
    % Warning if interpolation error is large
    if interp_error > 1e-3
        warning('Large interpolation error detected: %.2e', interp_error);
    end
end
