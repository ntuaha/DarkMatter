function y_result = darkmatter1(beta,location)

c = beta(1);
M = beta(2);
e = beta(3);
halo_x = beta(4);
halo_y = beta(5);

x = location(:,1);
y = location(:,2);

r = sqrt((x-halo_x).^2 + (y-halo_y).^2);
phi = atan((y-halo_y)./(x-halo_x));

F = M./(r+c);

l = length(phi);
s = l / 2;
y_result(1:s)  = e - F(1:s) .* cos(2*phi(1:s));
y_result(s+1:l)  = e - F(s+1:l) .* sin(2*phi(s+1:l));

