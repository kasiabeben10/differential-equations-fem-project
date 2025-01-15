%B(e_i,e_j) = B(e_j,e_i)
function result = B_matrix(n, i, j, x_i)
    %symmetry
    if j < i
        tmp = i;
        i = j;
        j = tmp;
    end

    result = -1 * base_function(n,i,2) * base_function(n,j,2); % -w(2)v(2)
    if j == i
        % main diagonal
        f1 = @(x) e_deriv(n, i, x) .* e_deriv(n,i,x); %w'v'
        f2 = @(x) base_function(n, i, x) .* base_function(n, i, x); %wv
        % using diffrent e pattern in x_i-1,x_i and x_i,x_i+1 
        result = result + ...
                integrate(f1, x_i(i-1), x_i(i)) + ...
                integrate(f1, x_i(i), x_i(i+1)) - ...
                integrate(f2,x_i(i-1),x_i(i)) - ...
                integrate(f2,x_i(i), x_i(i+1));    
    elseif j == i + 1
        % upper/lower diagonal
        f3 = @(x) e_deriv(n, i, x) * e_deriv(n, j, x); %w'v'
        f4 =@(x) base_function(n, i, x) * base_function(n, j, x); %wv
        % using diffrent e pattern in x_i-1,x_i and x_i,x_j and x_i,x_j+1 
        result = result + (integrate(f3, x_i(i-1), x_i(i)) + ...
                integrate(f3, x_i(i), x_i(j)) + ...
                integrate(f3, x_i(j), x_i(j+1)) - ...
                integrate(f4, x_i(i-1), x_i(i)) - ...
                integrate(f4, x_i(i), x_i(j)) - ...
                integrate(f4, x_i(j), x_i(j+1)));
    else
        result = 0;
    end
end