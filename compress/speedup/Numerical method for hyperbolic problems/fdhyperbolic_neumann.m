function [x,t,u] = fdhyperbolic_neumann(a,b,n,T,m,c,f,g)
    % Setup grid parameters
    h = (b-a)/n;
    k = T/m;
    x = linspace(a,b,n+1)';
    t = linspace(0,T,m+1);
    r = c*k/h;
    
    % Check CFL condition for stability
    if r > 1
        warning('CFL condition not satisfied: solution may be unstable');
    end

    % Initialize solution matrix
    u = zeros(n+1,m+1);
    
    % Initial conditions
    u(:,1) = f(x);

    % First time step using Taylor expansion
    for i = 2:n
        u(i,2) = u(i,1) + k*g(x(i)) + ...
                 (c^2*k^2/2)*(u(i+1,1) - 2*u(i,1) + u(i-1,1))/h^2;
    end

    % Boundary conditions
    u(1,:) = 0;  % Left Dirichlet BC: u(a,t) = 0
    
    % Right Neumann BC: u_x(b,t) = 0
    % Second-order one-sided difference approximation
    u(n+1,2) = (4*u(n,2) - u(n-1,2))/3;

    % Main time stepping loop using central difference scheme
    for j = 2:m
        % Interior points
        for i = 2:n
            u(i,j+1) = 2*u(i,j) - u(i,j-1) + ...
                       r^2*(u(i+1,j) - 2*u(i,j) + u(i-1,j));
        end
        
        % Right Neumann BC
        u(n+1,j+1) = (4*u(n,j+1) - u(n-1,j+1))/3;
    end
end