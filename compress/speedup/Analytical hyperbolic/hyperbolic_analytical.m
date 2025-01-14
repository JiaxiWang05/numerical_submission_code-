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
    B_padded(1:length(B)) = B/c;%This is because in the analytical solution, the time-dependent sine term includes B_n/c in its coefficient.
    %The change divides the B coefficients by the wave speed c to match the analytical solution of the wave equation. This is because the time derivative term in the initial conditions (represented by the B coefficients) needs to be scaled by 1/c in the solution formula.
    
    % Compute solution using vectorized operations
    u = sum(sin_x .* (A_padded .* cos_t + B_padded .* sin_t));
end
