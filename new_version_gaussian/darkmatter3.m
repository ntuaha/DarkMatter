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

x = location(:,1);
y = location(:,2);



r = -((x-X1).^2 + (y-Y1).^2)/C1;
r2 = -((x-X2).^2 + (y-Y2).^2)/C2;
r3 = -((x-X3).^2 + (y-Y3).^2)/C3;


phi = atan((y-Y1)./(x-X1));
phi2 = atan((y-Y2)./(x-X2));
phi3 = atan((y-Y3)./(x-X3));

F1 =  M1.*exp(r);
F2 =  M2.*exp(r2);
F3 =  M3.*exp(r3);


l = length(phi);
s = l / 2;
y_result(1:s)  = e - F1(1:s) .* cos(2*phi(1:s)) - F2(1:s) .* cos(2*phi2(1:s)) - F3(1:s) .* cos(2*phi3(1:s));
y_result(s+1:l)  = e - F1(s+1:l) .* sin(2*phi(s+1:l)) -F2(s+1:l).* sin(2*phi2(s+1:l)) -F3(s+1:l).* sin(2*phi3(s+1:l));

