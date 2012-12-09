function [X Y] = finmax(a,m)
f=a;
X = zeros(m,1);
Y = zeros(m,1);
for n=1:m
    [X(n) Y(n)]=find(f==max(max(f)));    
    f(X(n),Y(n))=-inf;    
end
