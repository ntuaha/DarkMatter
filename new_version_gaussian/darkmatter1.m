function y_result = darkmatter1(beta,location)

C1 = beta(1);
M1 = beta(2);
e = beta(3);
X1 = beta(4);
Y1 = beta(5);

x = location(:,1);
y = location(:,2);

r = -((x-X1).^2 + (y-Y1).^2)/C1;


phi = atan((y-Y1)./(x-X1));

F1 =  M1.*exp(r);

l = length(phi);
s = l / 2;
y_result(1:s)  = e - F1(1:s) .* cos(2*phi(1:s));
y_result(s+1:l)  = e - F1(s+1:l) .* sin(2*phi(s+1:l));

