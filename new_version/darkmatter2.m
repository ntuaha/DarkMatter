function y_result = darkmatter2(beta,location)

C1 = beta(1);
M1 = beta(2);
C2 = beta(3);
M2 = beta(4);
e = beta(5);
X1 = beta(6);
Y1 = beta(7);
X2 = beta(8);
Y2= beta(9);

x = location(:,1);
y = location(:,2);



r = sqrt((x-X1).^2 + (y-Y1).^2);
r2 = sqrt((x-X2).^2 + (y-Y2).^2);


phi = atan((y-Y1)./(x-X1));
phi2 = atan((y-Y2)./(x-X2));

F1 =  M1./(r+C1);
F2 =  M2./(r2+C2);


l = length(phi);
s = l / 2;
y_result(1:s)  = e - F1(1:s) .* cos(2*phi(1:s)) - F2(1:s) .* cos(2*phi2(1:s));
y_result(s+1:l)  = e - F1(s+1:l) .* sin(2*phi(s+1:l)) -F2(s+1:l).* sin(2*phi2(s+1:l));

