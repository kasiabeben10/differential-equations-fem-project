%integrate on range (a,b)
function result = integrate(f, a, b)
    % Transform function to standard interval [-1,1]
    g = @(x) f((x + 1)/2 * (b - a) + a);
    
    % Apply quadrature and scale
    result = gauss_quad(g) * (b - a)/2;
end