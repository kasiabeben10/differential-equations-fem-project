function result = gauss_quad(f)
    % 2-point Gauss-Legendre quadrature on [-1,1]
    xs = [-1/sqrt(3), 1/sqrt(3)];
    weights = [1, 1];
    
    % Evaluate function at quadrature points
    fx = arrayfun(f, xs);
    result = weights * fx';
end