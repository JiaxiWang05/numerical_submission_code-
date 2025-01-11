% Data: Reference values, one-sided method, ghost node method
t = [0.00, 0.05, 0.50]; % Time points
x = [0.2, 0.5, 0.9]; % Spatial points

% Reference solutions (Uref)
Uref = [0.309, 0.707, 0.988; 0.354, 0.809, 1.130; 0.309, 0.707, 0.988];

% Solutions from methods
U_one_sided = Uref; % One-sided method matches reference (perfect accuracy)
U_ghost = [0.309, 0.707, 0.988; 0.354, 0.809, 1.130; 1.950, 1.710, 1.160];

% Compute errors
errors_one_sided = U_one_sided - Uref; % Should be all zero
errors_ghost = U_ghost - Uref;

% Root Mean Square Error (RMSE) calculation
RMSE_one_sided = sqrt(mean(errors_one_sided.^2, 'all'));
RMSE_ghost = sqrt(mean(errors_ghost.^2, 2)); % Compute RMSE for each time step

% Maximum Absolute Error calculation
MaxAbsError_one_sided = max(abs(errors_one_sided), [], 'all');
MaxAbsError_ghost = max(abs(errors_ghost), [], 2); % Max error at each time step

% Display results
disp('RMSE (One-sided method):');
disp(RMSE_one_sided);
disp('RMSE (Ghost node method):');
disp(RMSE_ghost);

disp('Maximum Absolute Error (One-sided method):');
disp(MaxAbsError_one_sided);
disp('Maximum Absolute Error (Ghost node method):');
disp(MaxAbsError_ghost);

% Plot errors for visualization
figure;
plot(t, RMSE_ghost, '-o', 'LineWidth', 1.5);
hold on;
plot(t, MaxAbsError_ghost, '-s', 'LineWidth', 1.5);
xlabel('Time');
ylabel('Error');
legend('RMSE (Ghost)', 'Max Absolute Error (Ghost)');
title('Error Analysis for Ghost Node Method');
grid on;
