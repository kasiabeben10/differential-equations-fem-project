function d = e_deriv(n, i, x)
    h = 2/n;
    if i>n || x>2
        d = 0;
        return;
    end
    if(x >= h*(i-1) && x <= h*i)
        d = 1/h;
    elseif (x >= h*i && x <= h*(i+1))
        d = -1/h;
    else
        d = 0;
    end
end