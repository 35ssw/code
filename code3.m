% Parameter definition
T0 = 11.3;      % Initial temperature (°C)
alpha = 0.02;   % Carbon emission's impact on temperature coefficient
k_temp = 5;     % Glacier sensitivity to temperature changes
beta = 2;       % Nonlinear exponent for temperature's effect on ablation rate
gamma = 0.5;    % Background ablation speed
P0 = 100;       % Initial infrastructure cost
k = 5;          % Sensitivity of infrastructure cost to tourist number
w1 = 1;         % Weight of tourist number on satisfaction
w2 = 1;         % Weight of infrastructure cost on satisfaction
w3 = 1;         % Negative impact of glacier ablation speed on satisfaction

% Range of tourist number and tax rate
X_range = linspace(500, 5000, 50);  % Tourist number range from 500 to 5000, generate 50 points
Y_range = linspace(0.15, 0.25, 50); % Tax rate range from 0.15 to 0.25, generate 50 points

% Using meshgrid to generate the grid
[X_grid, Y_grid] = meshgrid(X_range, Y_range);  % Generate the grid

% Calculate infrastructure cost P(N_t) for each grid point
P_grid = P0 + k * log(X_grid + 1) + 11.7 * Y_grid;  % Relationship between infrastructure cost and tourist number

% Calculate carbon emission E for each grid point
E_grid = 66.13 * X_grid;  % Calculate carbon emission in million tons

% Calculate temperature T for each grid point
T_grid = T0 + alpha * log(E_grid + 1);  % Calculate temperature for each point

% Calculate glacier ablation speed G for each grid point
G_grid = k_temp * (T_grid.^beta) + gamma;  % Calculate glacier ablation speed

% Calculate tourist satisfaction S
S_grid = P_grid - G_grid;  % Tourist satisfaction is calculated as infrastructure cost minus the impact of glacier ablation

% Plot the results: 3D plot of tourist number vs. satisfaction
figure;
surf(X_grid, Y_grid, S_grid);  % Plot the 3D surface plot, z-axis is tourist satisfaction
xlabel('Tourist Number');
ylabel('Infrastructure Tax Rate');
zlabel('Tourist Satisfaction');
title('Relationship between Tourist Number, Tax Rate, and Tourist Satisfaction');

% Set gradient colors
shading interp;  % Smooth color gradient
colorbar;        % Display color bar

% Keep the grid of the axes
grid on;

% Parameter definition
T0 = 11.3;      % Initial temperature (°C)
alpha = 0.02;   % Carbon emission's impact on temperature coefficient
k_temp = 5;     % Glacier sensitivity to temperature changes
beta = 2;       % Nonlinear exponent for temperature's effect on ablation rate
gamma = 0.5;    % Background ablation speed
P0 = 100;       % Initial infrastructure cost
k = 5;          % Sensitivity of infrastructure cost to tourist number
w1 = 1;         % Weight of tourist number on satisfaction
w2 = 1;         % Weight of infrastructure cost on satisfaction
w3 = 1;         % Negative impact of glacier ablation speed on satisfaction

% Range of tourist number and tax rate
X_range = linspace(500, 5000, 50);  % Tourist number range from 500 to 5000, generate 50 points
Y_range = linspace(0.15, 0.25, 50); % Tax rate range from 0.15 to 0.25, generate 50 points

% Set a baseline for sensitivity analysis
baseline_N = 1000;  % Baseline tourist number
baseline_Y = 0.2;   % Baseline tax rate

% Sensitivity analysis for different parameters
sensitivity_N = zeros(1, length(X_range));  % Sensitivity for tourist number
sensitivity_Y = zeros(1, length(Y_range));  % Sensitivity for tax rate

% Univariate sensitivity analysis: Tourist number
for i = 1:length(X_range)
    % Modify tourist number N_t, keeping other parameters fixed
    N_temp = X_range(i);
    E_temp = 66.13 * N_temp;  % Calculate carbon emission
    T_temp = T0 + alpha * log(E_temp + 1);  % Calculate temperature
    G_temp = k_temp * (T_temp.^beta) + gamma;  % Calculate glacier ablation speed
    P_temp = P0 + k * log(N_temp + 1) + 11.7 * baseline_Y;  % Calculate infrastructure cost
    S_temp = P_temp - G_temp;  % Calculate tourist satisfaction
    sensitivity_N(i) = S_temp;  % Store corresponding satisfaction
end

% Univariate sensitivity analysis: Tax rate
for i = 1:length(Y_range)
    % Modify tax rate Y, keeping other parameters fixed
    Y_temp = Y_range(i);
    E_temp = 66.13 * baseline_N;  % Calculate carbon emission
    T_temp = T0 + alpha * log(E_temp + 1);  % Calculate temperature
    G_temp = k_temp * (T_temp.^beta) + gamma;  % Calculate glacier ablation speed
    P_temp = P0 + k * log(baseline_N + 1) + 11.7 * Y_temp;  % Calculate infrastructure cost
    S_temp = P_temp - G_temp;  % Calculate tourist satisfaction
    sensitivity_Y(i) = S_temp;  % Store corresponding satisfaction
end

% Plot the sensitivity analysis results
figure;
subplot(1,2,1);
plot(X_range, sensitivity_N, 'LineWidth', 2);
xlabel('Tourist Number');
ylabel('Tourist Satisfaction');
title('Sensitivity Analysis: Tourist Number vs Satisfaction');
grid on;

subplot(1,2,2);
plot(Y_range, sensitivity_Y, 'LineWidth', 2);
xlabel('Tax Rate');
ylabel('Tourist Satisfaction');
title('Sensitivity Analysis: Tax Rate vs Satisfaction');
grid on;
