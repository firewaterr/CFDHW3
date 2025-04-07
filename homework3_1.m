% Lax Scheme                        %
% \partial_t u + \partial_x u = 0   %   
% u(x,0) = sin(2 * pi *x)           %
% 0 <= x <= 3                       %
% symeetric boundary conditions     %
% u(0,t) = u(3,t)                   %

clear all; 
close all; 
clc;

%% Parameters
L = 3; % Length of the domain
N = [100,300,600]; % Number of grid points
T = 1; % Total time
dt = 0.01; % Time step
t = 0:dt:T; % Time vector
M = length(t); % Number of time steps
a = 1; 
Schemetitle = ["LaxScheme", "UpwindScheme", "ImplicitScheme"]; % Scheme titles
for cyclenum = 1:length(N)
    %% Solution matrix
    x = linspace(0, L, N(cyclenum)); % Grid points
    u = sin(2 * pi * x); % Initial condition
    dx = L / N(cyclenum); % Grid spacing
    c = a * dt / dx; % CFL number
    Ulax = LaxScheme(N(cyclenum), M, c, u);             % Lax scheme function
    Uupwind = UpwindScheme(N(cyclenum), M, c, u);       % Upwind scheme function
    Uimplicit = ImplicitScheme(N(cyclenum), M, c, u);   % Implicit scheme function
    U = {Ulax, Uupwind, Uimplicit}; % Create a cell array with the three matrices
    %% Plot the results
    for fignum = 1:length(U)
        figure;
        surf(x, t, U{fignum}','EdgeColor','none'); % Surface plot
        xlabel('x'); % x-axis label
        ylabel('t'); % y-axis label
        zlabel('u'); % z-axis label
        title([Schemetitle(fignum) + " | c = " + num2str(c)]); % Title with scheme name and CFL number in one row
        view(2); % View from above
        axis tight; % Tight axis
        grid on; % Grid on
        colorbar; % Colorbar
        colormap(jet); % Colormap
        clim([-1 1]); % Color limits
    end
end

%% Lax Scheme function
function U = LaxScheme(N, M, c, u)
    U = zeros(N, M); % Initialize the solution matrix
    U(:, 1) = u; % Set the initial condition
    for m = 1:M-1
        for n = 2:N-1
            U(n, m+1) = 0.5 * (1-c) * U(n+1,m) + 0.5 * (1+c) * U(n-1,m);
        end
        % Apply periodic boundary conditions
        U(1, m+1) = 0.5 * (1-c) * U(2,m) + 0.5 * (1+c) * U(N-1,m);
        U(N, m+1) = U(1, m+1);
    end
end
%% Upwind Scheme function
function U = UpwindScheme(N, M, c, u)
    U = zeros(N, M); % Initialize the solution matrix
    U(:, 1) = u; % Set the initial condition
    for m = 1:M-1
        for n = 2:N-1
            U(n, m+1) = U(n, m) - c * (U(n, m) - U(n-1, m));
        end
        % Apply periodic boundary conditions
        U(1, m+1) = U(1, m) - c * (U(1, m) - U(N-1, m));
        U(N, m+1) = U(1, m+1);
    end
end
%% Implicit Scheme function
function U = ImplicitScheme(N, M, c, u)
    U = zeros(N, M); % Initialize the solution matrix
    U(:, 1) = u; % Set the initial condition
    A = zeros(N, N); % Implicit scheme matrix initialization
    for i =  1:N
        A(i, i) = 1;
        if i == 1
            A(i, N) = -1 * c / 2;
            A(i, i+1) = 1 * c / 2;
        elseif i == N % symmetric boundary condition
            A(i, 1) = 1 * c / 2;
            A(i, i-1) = -1 * c / 2;
        else          % symmetric boundary condition
            A(i, i-1) = -1/2 * c;
            A(i, i+1) = 1/2 * c;
        end
    end
    for m = 1:M-1
        b = U(:, m);
        U(:, m+1) = A \ b;
    end
end