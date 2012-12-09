function y_result = darkmatter3(beta,location)

    c = beta(1);
    M = beta(2);
    e = beta(3);
    halo_x = beta(4);
    halo_y = beta(5);
    tt = beta(6);
    ee = beta(7);
    
    x = location(:,1);
    y = location(:,2);
    x1 = location(:,3);
    y1 = location(:,4);
    c1 = location(:,5);
    M1 = location(:,6);
    e1 = location(:,7);
    
    
    r = sqrt((x-x1).^2 + (y-y1).^2);
    r2 = sqrt((x-halo_x).^2 + (y-halo_y).^2);
    
    %t1 = ((x-halo_x) / (y-halo_y)).^2;
    %c1 = (1-t1)./(1+t1);
    
    %t2 = ((x-halo_x2) / (y-halo_y2)).^2;
    %c2 = (1-t2)./(1+t2);
    
    phi = atan((y-y1)./(x-x1));    
    phi2 = atan((y-halo_y)./(x-halo_x));

    F1 =  M1./(r+c1);
    F2 =  M./(r2).^tt;
    
    
    l = length(phi);
    s = l / 2;
    y_result(1:s)  = e - F1(1:s) .* cos(2*phi(1:s)) - F2(1:s) .* cos(2*phi2(1:s));
    y_result(s+1:l)  = ee - F1(s+1:l) .* sin(2*phi(s+1:l)) -F2(s+1:l).* sin(2*phi2(s+1:l));
    %y_result  = e - M*(1./(r+c) .* c1 + 1./(r2+c) .*c2);
    