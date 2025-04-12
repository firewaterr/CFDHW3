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
N = [400,800]; % Number of grid points
T = 3; % Total time
M = [500,1000]; % Time step size
a = 1; 
Schemetitle = ["LaxScheme", "UpwindScheme", "ImplicitScheme"]; % Scheme titles
Error = zeros(3, length(N)); % Error initialization
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
    Error(1, cyclenum) = CalError(Ureal, Ulax, N(cyclenum), M(cyclenum)); % Calculate error for Lax scheme
    Error(2, cyclenum) = CalError(Ureal, Uupwind, N(cyclenum), M(cyclenum)); % Calculate error for Upwind scheme
    Error(3, cyclenum) = CalError(Ureal, Uimplicit, N(cyclenum), M(cyclenum)); % Calculate error for Implicit scheme
end
p = zeros(3, 1); % Initialize error vector
p = Error(:,1)./ Error(:,2); % Calculate the ratio of errors
p = log2(p)
function Error = CalError(U1, U2, N, M)
    % Calculate the error between the real solution and the numerical solution
    Error = 0; % Initialize error vector
    for i = 1:N
        for j = 1:M
            Error = Error + (U1(i, j) - U2(i, j))^2; % Calculate the error
        end
    end
    Error = sqrt(Error / (N * M)); 
end
