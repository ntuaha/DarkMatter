function y_result = darkmatter(beta,location)

    c = beta(1);
    M = beta(2);
    e = beta(3);
    halo_x = beta(4);
    halo_y = beta(5);

    x = location(:,1);
    y = location(:,2);
    
    r = sqrt((x-halo_x).^2 + (y-halo_y).^2);
    %r = getDistance(x,y,halo_x,halo_y);
    phi = atan((y-halo_y)./(x-halo_x));
    
    l = length(phi);
    s = l / 2;
    y_result(1:s)  = e - M./(r(1:s)+c) .* cos(2*phi(1:s));
    y_result(s+1:l)  = e - M./(r(s+1:l)+c) .* sin(2*phi(s+1:l));
    
    