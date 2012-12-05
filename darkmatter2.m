function y_result = darkmatter2(beta,location)

    c = beta(1);
    M = beta(2);
    e = beta(3);
    halo_x = beta(4);
    halo_y = beta(5);
    halo_x2 = beta(6);
    halo_y2 = beta(7);

    x = location(:,1);
    y = location(:,2);
    
    r = sqrt((x-halo_x).^2 + (y-halo_y).^2);
    r2 = sqrt((x-halo_x2).^2 + (y-halo_y2).^2);
    
    t1 = ((x-halo_x) / (y-halo_y)).^2;
    c1 = (1-t1)/(1+t1);
    
    t2 = ((x-halo_x2) / (y-halo_y2)).^2;
    c2 = (1-t2)/(1+t2);
    
    %phi = atan((y-halo_y)./(x-halo_x));
    
    %phi2 = atan((y-halo_y2)./(x-halo_x2));

    
    
    
    %l = length(phi);
    %s = l / 2;
    %y_result(1:s)  = e - M./(r(1:s)+c) .* cos(2*phi(1:s)) - M./(r2(1:s)+c) .* cos(2*phi2(1:s));
    %y_result(s+1:l)  = e - M./(r(s+1:l)+c) .* sin(2*phi(s+1:l)) - M./(r2(1:s)+c) .* sin(2*phi2(1:s));
    y_result  = e - M*(1./(r+c) .* c1 + 1./(r2+c) .*c2);
    