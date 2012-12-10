function  [C1 M1 C2 M2 E X1 Y1 X2 Y2 norm]=subfunction2(step,index, x,y,e1,e2,x_start,y_start)

c1 = 1000;
m1 = 1;
c2 = 1000;
m2 = 1;
e = 0;
beta0 = [c1,m1,c2,m2,e,x_start(1),y_start(1),x_start(2),y_start(2)];
[C1 M1 C2 M2 E X1 Y1 X2 Y2 norm] = findHalo2(index,beta0,x,y,e1,e2);