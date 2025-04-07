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