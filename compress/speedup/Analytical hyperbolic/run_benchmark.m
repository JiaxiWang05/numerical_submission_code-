% Benchmark script
clear;
clc;

% Parameters from Table 7
L = 1;
c = 2;
A = [1, 2, 3];
B = [-1, 0, 2, -1];

% Test points from Table 6
x_values = [0.2, 0.5, 0.9];
t_values = [0, 1, 2];

% Number of repetitions for more accurate timing
n_repeats = 1000;

fprintf('Running benchmark with %d repetitions...\n\n', n_repeats);

% Test vectorized version
tic
for rep = 1:n_repeats
    for i = 1:length(x_values)
        for j = 1:length(t_values)
            results_vec(i,j) = hyperbolic_analytical(x_values(i), t_values(j), L, c, A, B);
        end
    end
end
time_vec = toc;

% Test loop version
tic
for rep = 1:n_repeats
    for i = 1:length(x_values)
        for j = 1:length(t_values)
            results_loop(i,j) = hyperbolic_analytical_loop(x_values(i), t_values(j), L, c, A, B);
        end
    end
end
time_loop = toc;

% Display timing results
fprintf('Average time per full table calculation:\n');
fprintf('Vectorized version: %.6f ms\n', (time_vec/n_repeats)*1000);
fprintf('Loop version: %.6f ms\n', (time_loop/n_repeats)*1000);
fprintf('Speed ratio (loop/vec): %.2fx\n\n', time_loop/time_vec);

% Display results
fprintf('Table 6 values:\n');
fprintf('   t     x          u\n');
fprintf('------------------------\n');
for j = 1:length(t_values)
    for i = 1:length(x_values)
        fprintf('%4.1f  %4.1f  %10.6f\n', t_values(j), x_values(i), results_vec(i,j));
    end
end