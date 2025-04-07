% homework3.1                       %
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
N = [50,100,200]; % Number of grid points
T = 3; % Total time
dt = 0.01; % Time step size
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