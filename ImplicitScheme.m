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