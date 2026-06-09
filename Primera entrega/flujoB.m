
function phiB = flujoB(Bz_slice, x, y, R2)                        
    [X, Y]   = meshgrid(x, y);
    mask     = (X.^2 + Y.^2) <= R2^2;
    dA       = abs((x(2) - x(1)) * (y(2) - y(1))); 
    phiB     = sum(Bz_slice(mask), 'all') * dA;
end