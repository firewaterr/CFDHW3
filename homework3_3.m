% homework3.2                       %
% \partial_t u + \partial_x u = 0   %   
% u(x,0) = sin(2 * pi *x)           %
% 0 <= x <= 3                       %
% symmetric boundary conditions     %
% u(0,t) = u(3,t)                   %

clear all;
close all; 
clc;

%% Parameters
L = 3; % Length of the domain
N = 200; % Number of grid points
T = 3; % Total time
M = 400; % Time step size
a = 1; 
Schemetitle = ["LaxScheme", "UpwindScheme", "ImplicitScheme"]; % Scheme titles
x = linspace(0, L, N); % Grid points
t = linspace(0, T, M); % Time vector
u = sin(2 * pi * x); % Initial condition
dx = L / N; % Grid spacing
dt = T / M; % Time step size
c = a * dt / dx; % CFL number
%% Solution matrix
Ulax = LaxScheme(N, M, c, u);             % Lax scheme function
Uupwind = UpwindScheme(N, M, c, u);       % Upwind scheme function
Uimplicit = ImplicitScheme(N, M, c, u);   % Implicit scheme function
Ureal = RealU(N, M, x, t);             % Real solution function

%% Plot for final time
ftlax = Ulax(:,end); % Lax scheme solution at final time
ftupwind = Uupwind(:,end); % Upwind scheme solution at final time
ftimplicit = Uimplicit(:,end); % Implicit scheme solution at final time
ftreal = Ureal(:,end); % Real solution at final time
figure;
plot(x, ftlax, 'r', 'LineWidth', 2); % Lax scheme solution
hold on;
plot(x, ftupwind, 'g', 'LineWidth', 2); % Upwind scheme solution
hold on;
plot(x, ftimplicit, 'b', 'LineWidth', 2); % Implicit scheme solution
hold on;
plot(x, ftreal, 'k', 'LineWidth', 2); % Real solution
hold on;
title(['Lax, Upwind, Implicit and Real Solution for N = ', num2str(N), ', M = ', num2str(M)]);
xlabel('x'); % x-axis label
ylabel('u'); % y-axis label
legend('Lax', 'Upwind', 'Implicit', 'Real','Location','southeast'); % Legend
grid on; % Grid

%% Plot for final time
fxlax = Ulax(end,:); % Lax scheme solution at final x
fxupwind = Uupwind(end,:); % Upwind scheme solution at final x
fximplicit = Uimplicit(end,:); % Implicit scheme solution at final x
fxreal = Ureal(end,:); % Real solution at final x
figure;
plot(t, fxlax, 'r', 'LineWidth', 2); % Lax scheme solution
hold on;
plot(t, fxupwind, 'g', 'LineWidth', 2); % Upwind scheme solution
hold on;
plot(t, fximplicit, 'b', 'LineWidth', 2); % Implicit scheme solution
hold on;
plot(t, fxreal, 'k', 'LineWidth', 2); % Real solution
hold on;
title(['Lax, Upwind, Implicit and Real Solution for N = ', num2str(N), ', M = ', num2str(M)]);
xlabel('t'); % x-axis label
ylabel('u'); % y-axis label
legend('Lax', 'Upwind', 'Implicit', 'Real','Location','southeast'); % Legend
grid on; % Grid
