% visitor numbers and revenue
p = 44852;      % Average income per tourist
g = 0.03;       % tourist growth rate
N0 = 403303;    % Initial number of visitors


alpha = 0.0001;    % The burden factor of each tourist on the environment
beta = 0.00005;    % The burden factor of infrastructure per tourist
N_max = 510000;    % Maximum number of visitors
E_max = 200000;    % Maximum environmental pressure
C_max = 150000;    % Maximum infrastructure burden

% nonlinear constraint
constraint1 = @(N) alpha * N^2 - E_max;   % Environmental pressure constraint
constraint2 = @(N) beta * N^2 - C_max;    % Infrastructure burden constraints

% Maximize revenue
objective = @(N) -p * N;  % Linprog finds the minimum value, so take the negative sign

% Define the initial 
N_initial = N0;

% Solving Nonlinear Programming Problems
options = optimset('Display', 'off', 'TolFun', 1e-6);  
result = fmincon(objective, N_initial, [], [], [], [], 0, N_max, @(N)deal([constraint1(N), constraint2(N)], []), options);

% optimal solution
N_optimal = result;
I_optimal = p * N_optimal;

% output result
fprintf('最优游客数量: %.6f\n', N_optimal);
fprintf('最优旅游收入: %.6f\n', I_optimal);
fprintf('环境压力: %.6f\n', alpha * N_optimal^2);
fprintf('基础设施负担: %.6f\n', beta * N_optimal^2);
