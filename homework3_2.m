% homework3.2                       %
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
N = [50,100]; % Number of grid points
T = 3; % Total time
M = [50,100]; % Time step size
a = 1; 
Schemetitle = ["LaxScheme", "UpwindScheme", "ImplicitScheme"]; % Scheme titles
for cyclenum = 1:length(N)
    %% Solution matrix
    x = linspace(0, L, N(cyclenum)); % Grid points
    t = linspace(0, T, M(cyclenum)); % Time vector
    u = sin(2 * pi * x); % Initial condition
    dx = L / N(cyclenum); % Grid spacing
    dt = T / M(cyclenum); % Time step size
    c = a * dt / dx; % CFL number
    Ulax = LaxScheme(N(cyclenum), M(cyclenum), c, u);             % Lax scheme function
    Uupwind = UpwindScheme(N(cyclenum), M(cyclenum), c, u);       % Upwind scheme function
    Uimplicit = ImplicitScheme(N(cyclenum), M(cyclenum), c, u);   % Implicit scheme function
    Ureal = RealU(N(cyclenum), M(cyclenum), x, t);             % Real solution function
    
end
