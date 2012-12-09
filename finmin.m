function [X Y] = finmin(a,m)

f=a;
X = zeros(m,1);
Y = zeros(m,1);
for n =1:m
    [X(n) Y(n)]=find(f==min(min(f)));
    f(X(n),Y(n))=inf;
end
