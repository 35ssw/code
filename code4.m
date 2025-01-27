% Define parameters
p = 900;        % Average revenue per tourist
g = 0.065;      % Tourist growth rate (fixed at 0.065)
N0 = 827;       % Initial number of tourists
N_max = 850;    % Maximum number of tourists (modified to 850)

% Set initial parameters (adjusted burden coefficients and maximum values based on volcanic background)
alpha = 0.001;    % Burden coefficient per tourist on the environment (volcanic background)
beta = 0.0015;    % Burden coefficient per tourist on infrastructure (volcanic background)
E_max = 500000;   % Maximum environmental pressure due to volcanic activity (increased max environmental pressure)
C_max = 250000;   % Maximum infrastructure burden due to volcanic activity

% Nonlinear constraints
constraint1 = @(N) alpha * N.^2 - E_max;   % Environmental pressure constraint
constraint2 = @(N) beta * N.^2 - C_max;    % Infrastructure burden constraint

% Objective function: maximize revenue
objective = @(N) -p * N;  % The goal is to maximize revenue, hence the negative sign because linprog minimizes the function

% Define initial guess
N_initial = N0;

% Set optimization options
options = optimset('Display', 'off', 'TolFun', 1e-6);  % Set optimization options, turning off display and specifying tolerance for error

% Solve the nonlinear programming problem
result = fmincon(objective, N_initial, [], [], [], [], 0, N_max, @(N)deal([constraint1(N), constraint2(N)], []), options);

% Optimal solution
N_optimal = result;
I_optimal = p * N_optimal;  % Calculate optimal revenue

% Output results
fprintf('Optimal number of tourists: %.6f\n', N_optimal);
fprintf('Optimal tourism revenue: %.6f\n', I_optimal);
fprintf('Environmental pressure: %.6f\n', alpha * N_optimal^2);
fprintf('Infrastructure burden: %.6f\n', beta * N_optimal^2);
