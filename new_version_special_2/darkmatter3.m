function y_result = darkmatter3(beta,location)

    C1 = beta(1);
    M1 = beta(2);
    C2 = beta(3);
    M2 = beta(4);
    C3 = beta(5);
    M3 = beta(6);
    e = beta(7);
    X1 = beta(8);
    Y1= beta(9);
    X2 = beta(10);
    Y2= beta(11);
    X3 = beta(12);
    Y3= beta(13);
    
    C12= beta(14);
    C23= beta(15);
    C13= beta(16);
    C123= beta(17);
    
    
    R1 = beta(18);
    R2 = beta(19);
    R3 = beta(20);
    R12 = beta(21);
    R23 = beta(22);
    R13 = beta(23);
    R123 = beta(24);

    
    
    x = location(:,1);
    y = location(:,2);
 
    M12 = M1+M2;
    M23 = M2+M3;
    M13 = M1+M3;
    M123 = M1+M2+M3;
    
    X12 =  (M1*X1 + M2*X2) / M12;
    Y12 =  (M1*Y1 + M2*Y2) / M12;
    
    X23 = (M2*X2 + M3*X3) / M23;
    Y23=  (M2*Y2 + M3*Y3) / M23;
    
    X13 =  (M1*X1 + M3*X3) / M13;
    Y13 =  (M1*Y1 + M3*Y3) / M13;
    
    X123 =  (M1*X1 + M2*X2 + M3*X3) / M123;
    Y123 =  (M1*Y1 + M2*Y2 + M3*X3) / M123;
    
    r = sqrt((x-X1).^2 + (y-Y1).^2);
    r2 = sqrt((x-X2).^2 + (y-Y2).^2);
    r3 = sqrt((x-X3).^2 + (y-Y3).^2);
    
    
    r12 = sqrt((x-X12).^2 + (y-Y12).^2);
    r23 = sqrt((x-X23).^2 + (y-Y23).^2);
    r13 = sqrt((x-X13).^2 + (y-Y13).^2);
    r123 = sqrt((x-X123).^2 + (y-Y123));
    
    phi = atan((y-Y1)./(x-X1));    
    phi2 = atan((y-Y2)./(x-X2));
    phi3 = atan((y-Y3)./(x-X3));
    
    phi12 = atan((y-Y12)./(x-X12));    
    phi23 = atan((y-Y23)./(x-X23));
    phi13 = atan((y-Y13)./(x-X13));
    phi123 = atan((y-Y123)./(x-X123));

    F1 =  R1.*M1./(r+C1);
    F2 =  R2.*M2./(r2+C2);
    F3 =  R3.*M3./(r3+C3);
    
    F12 =  R12.*M12./(r12+C12);
    F23 =  R23.*M23./(r23+C23);
    F13 =  R13.*M13./(r13+C13);
    F123 =  R123.*M123./(r123+C123);

    
    
    l = length(phi);
    s = l / 2;
    y_result(1:s)  = e - F1(1:s) .* cos(2*phi(1:s)) - F2(1:s) .* cos(2*phi2(1:s)) - F3(1:s) .* cos(2*phi3(1:s)) - F12(1:s) .* cos(2*phi12(1:s)) - F23(1:s) .* cos(2*phi23(1:s)) - F13(1:s) .* cos(2*phi13(1:s)) - F123(1:s) .* cos(2*phi123(1:s)) ;
    y_result(s+1:l)  = e - F1(s+1:l) .* sin(2*phi(s+1:l)) -F2(s+1:l).* sin(2*phi2(s+1:l)) -F3(s+1:l).* sin(2*phi3(s+1:l))  - F12(1:s) .* sin(2*phi12(1:s)) - F23(1:s) .* sin(2*phi23(1:s)) - F13(1:s) .* sin(2*phi13(1:s)) - F123(1:s) .* sin(2*phi123(1:s));
    
    