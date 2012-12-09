function  [C1 M1 C2 M2 C3 M3 E X1 Y1 X2 Y2 X3 Y3 norm]=subfunction3(step,index, x,y,e1,e2,x_start,y_start)

c1 = 1000;
m1 = 1;
c2 = 1000;
m2 = 1;
c3 = 1000;
m3 = 1;
e = 0;
beta0 = [c1,m1,c2,m2,c3,m3,e,x_start(1),y_start(1),x_start(2),y_start(2),x_start(3),y_start(3)];
[C1 M1 C2 M2 C3 M3 E X1 Y1 X2 Y2 X3 Y3 norm] = findHalo3(index,beta0,x,y,e1,e2);