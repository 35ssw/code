% Define constant parameters
K0 = 0.035;
k1 = 0.32e-5;
b = 11.3;
T0 = 0;
k2 = 44852;
M = -70000;
m = 11.7e4;
k3 = 2.1;
w1 = 0.4;
w2 = 0.5;
w3 = 0.1;
X2 = 517650;
Y1 = 0.14;
Y2 = 0.2;
R1 = 48845628;
S1 = 1e5;
A1 = 3.08;

% Define the coefficient vector for the objective function
% First, expand the objective function f(x) = w1*R - w2*A - w3*S
% R = k2*x + M + m*y
% A = K0*((k1*x + b) - T0)
% S = k3*x
% f(x) = w1*(k2*x + M + m*y) - w2*K0*((k1*x + b) - T0) - w3*k3*x
% Simplified to f(x) = (w1*k2 - w2*K0*k1 - w3*k3)*x + w1*m*y + w1*M - w2*K0*(b - T0)
% Linear programming focuses only on the coefficients of the variables, constants don't affect the optimal solution
f = [-(w1*k2 - w2*K0*k1 - w3*k3), -w1*m]; 

% Define the inequality constraint matrix A and vector b
A = [1, 0;         % x <= X2
     0, 1;         % y <= Y2
     0, -1;        % -y <= -Y1
    -k2, -m;       % -k2*x - m*y <= -R1 - M
     k3, 0;        % k3*x <= S1
     K0*k1, 0];     % K0*k1*x <= A1 + K0*(T0 - b)
b = [X2; Y2; -Y1; -R1 - M; S1; A1 + K0*(T0 - b)];

% Define the equality constraint matrix Aeq and vector beq, here there are no equality constraints, so they are empty
Aeq = [];
beq = [];

% Define the lower and upper bounds for the variables
lb = [0, 0];  % Lower bounds for variables x and y
ub = [X2, Y2]; % Upper bounds for variables x and y

% Specify the indices of the integer variables, here x is the first variable, so its index is 1
intcon = 1;

% Use the intlinprog function to solve the integer linear programming problem
[x_opt, fval_opt] = intlinprog(f, intcon, A, b, Aeq, beq, lb, ub);

% Output the results
if ~isempty(x_opt)
    disp(['Optimal solution x = ', num2str(x_opt(1)), ', y = ', num2str(x_opt(2))]);
    disp(['Maximum value of the objective function f(x) = ', num2str(-fval_opt)]);
else
    disp('No optimal solution found that satisfies the constraints.');
end
