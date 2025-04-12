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