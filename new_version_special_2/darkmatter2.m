function y_result = darkmatter2(beta,location)

C1 = beta(1);
M1 = beta(2);
C2 = beta(3);
M2 = beta(4);
e1 = beta(5);
X1 = beta(6);
Y1 = beta(7);
X2 = beta(8);
Y2= beta(9);
C12= beta(10);
R1 = beta(11);
R2 = beta(12);
R12 = beta(13);
e2 = beta(14);

x = location(:,1);
y = location(:,2);

M12 =  M1+M2;
X12 =  (M1*X1 + M2*X2) / M12;
Y12 =  (M1*Y1 + M2*Y2) / M12;

r = sqrt((x-X1).^2 + (y-Y1).^2);
r2 = sqrt((x-X2).^2 + (y-Y2).^2);
r12 = sqrt((x-X12).^2 + (y-Y12).^2);

phi = atan((y-Y1)./(x-X1));
phi2 = atan((y-Y2)./(x-X2));
phi12 = atan((y-Y12)./(x-X12));

F1 =  R1.*M1./(r+C1);
F2 =  R2.*M2./(r2+C2);
F12 =  R12*(M12)./(r12+C12);


l = length(phi);
s = l / 2;
y_result(1:s)  = e1 - F1(1:s) .* cos(2*phi(1:s)) - F2(1:s) .* cos(2*phi2(1:s)) - F12(1:s) .* cos(2*phi12(1:s));
y_result(s+1:l)  = e2 - F1(s+1:l) .* sin(2*phi(s+1:l)) -F2(s+1:l).* sin(2*phi2(s+1:l)) - F12(s+1:l).* sin(2*phi12(s+1:l));
