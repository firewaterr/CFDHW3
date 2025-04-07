%% Real U function
function U = RealU(N, M, x, t)
    U = zeros(N, M); % Initialize the solution matrix
    for m = 1:M
        for n = 1:N
            U(n, m) = sin(2*pi*(x(n) - t(m)));
        end
    end
end