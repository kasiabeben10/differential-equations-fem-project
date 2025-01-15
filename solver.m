function solver(n)
%% Finite Element Method for solving
    % -d^2u/dx^2 - u = sin(x) 
    % on [0, 2] with boundary conditions:
    % u(0) = 1 and du/dx(2) - u(2) = 4

    if nargin < 1
        error('Please provide the number of elements as input.');
    end

    % nodes x_i
    x_i = @(i) 2*i/n;

    %shift
    u_tilde = @(x) base_function(n, 0, x);
    u_tilde_prim = @(x) e_deriv(n, 0, x);
    

    A = zeros(n+1,n+1); %B(e_i,e_j) matrix
    Y = zeros(n+1, 1); %L matrix
    A(1,1) = 1;
    Y(1) = 0;
    for i = 2:n+1
        for j = 2:n+1
            if abs(i-j) <= 1
                A(i,j) = B_matrix(n, i-1, j-1, x_i);
            end
        end
        Y(i) = L_matrix(n, i-1, x_i, u_tilde, u_tilde_prim);
    end
    % Solve
    weights = A\Y;
    
    % Plot solution
    x = linspace(0, 2, 1000);
    u = zeros(size(x));
    for k = 1:length(x)
        u(k) = u_tilde(x(k)); %shift
        for i = 1:n+1
            u(k) = u(k) + weights(i)*base_function(n, i-1, x(k));
        end
    end
    
    figure;
    plot(x, u, 'k-', 'LineWidth', 2);
    xlabel('x', 'Interpreter', 'latex', 'FontSize', 14);
    ylabel('u(x)', 'Interpreter', 'latex', 'FontSize', 14);
    grid on;
    grid minor;
    saveas(gcf, 'plot.png');
end

