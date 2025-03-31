% first order upwind scheme         %
% \partial_t u + \partial_x u = 0   %
% u(x,0) = sin(2 * pi *x)           %
% 0 <= x <= 3                       %
% symeetric boundary conditions     %
% u(0,t) = u(3,t)                   %
clear all; close all; clc;

% Parameters
L = 3; % Length of the domain
N = 300; % Number of grid points
x = linspace(0, L, N); % Grid points
u = sin(2 * pi * x); % Initial condition
dt = 0.01; % Time step
T = 3; % Total time
t = 0:dt:T; % Time vector
M = length(t); % Number of time steps
% Initialize the solution matrix
U = zeros(N, M); % Solution matrix
U(:, 1) = u; % Initial condition
% Lax scheme parameters
c = 1; % Courant number
dx = L / N; % Grid spacing
lambda = c * dt / dx; % Lax number
% Lax scheme loop
for m = 1:M-1
    for n = 2:N-1
        U(n, m+1) = U(n, m) - lambda * (U(n, m) - U(n-1, m));
    end
    % Apply periodic boundary conditions
    U(1, m+1) = U(1, m) - lambda * (U(1, m) - U(N-1, m));
    U(N, m+1) = U(1, m+1);
end
% Plot the results
figure;
surf(x, t, U','EdgeColor','none'); % Surface plot
xlabel('x'); % x-axis label
ylabel('t'); % y-axis label
zlabel('u'); % z-axis label
title('Lax Scheme for \partial_t u + \partial_x u = 0'); % Title
view(2); % View from above
axis tight; % Tight axis
grid on; % Grid on
colorbar; % Colorbar
% Set colormap
colormap(jet); % Colormap
% Set color limits
clim([-1 1]); % Color limits
% Set colorbar limits

