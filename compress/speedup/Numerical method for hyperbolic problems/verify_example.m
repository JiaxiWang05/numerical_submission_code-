function [x,t,u] = fdhyperbolic_neumann(a,b,n,T,m,c,f,g)
% fdhyperbolic_neumann   Finite Difference method to solve a hyperbolic PDE with Neumann BC.
%         This routine solves the problem u_tt(x,t) = c^2 u_xx(x,t) in 
%         [a,b] x [0,T] with u(a,t) = 0, u_x(b,t) = 0 and u(x,0) = f(x),
%         u_t(x,0) = g(x)
%
% inputs:   a,b - Extrema
%           n - Number of subintervals
%           T - Final time
%           m - Number of steps in time
%           c - Coefficient c
%           f - Initial value for u
%           g - Initial value for u_t
%
% output:  x - Nodes of the partition
%          t - Nodes in time
%          u - Values of the computed solution at the nodes

h = (b-a)/n;                     % calculate the size of h
k = T/m;                         % calculate the size of k, the timestep
x = (a:h:b)';                    % generate the nodes
t = (0:k:T);                     % generate the nodes in time
r = c*k/h;                       % CFL number

u = zeros(n+1,m+1);              % initialize solution

% Initial conditions
u(2:n,1) = f(x(2:n));           % apply the initial value to u

% First time step using modified equation
u(2:n,2) = (1-r^2)*f(x(2:n)) + k*g(x(2:n)) + ...
    (r^2/2)*(f(x(3:n+1)) + f(x(1:n-1)));

% Boundary conditions
u(1,:) = 0;                      % Left BC: u(a,t) = 0

% Right Neumann BC: u_x(b,t) = 0
% Use second-order approximation
u(n+1,1) = f(x(n+1));           % Initial condition at right boundary
u(n+1,2) = (1-r^2)*f(x(n+1)) + k*g(x(n+1)) + r^2*f(x(n));

% Main time-stepping loop
for ct = 2:m
    % Interior points
    u(2:n,ct+1) = (2-2*r^2)*u(2:n,ct) + r^2*(u(3:n+1,ct) + u(1:n-1,ct)) - u(2:n,ct-1);
    
    % Right boundary (Neumann condition)
    u(n+1,ct+1) = (2-2*r^2)*u(n+1,ct) + 2*r^2*u(n,ct) - u(n+1,ct-1);
end

end