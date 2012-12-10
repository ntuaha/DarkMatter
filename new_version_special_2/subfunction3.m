function  [C1 M1 C2 M2 C3 M3 E X1 Y1 X2 Y2 X3 Y3 norm]=subfunction3(step,index, x,y,e1,e2,x_start,y_start)

c1 = 1000;
m1 = 1;
c2 = 1000;
m2 = 1;
c3 = 1000;
m3 = 1;
e = 0;
c12 = 1e6;
c23 = 1e6;
c13 = 1e6;
c123 = 1e6;
r1 = 1;
r2 = 1;
r3 = 1;
r12 = 1;
r23 = 1;
r13 = 1;
r123 = 1;


beta0 = [c1,m1,c2,m2,c3,m3,e,x_start(1),y_start(1),x_start(2),y_start(2),x_start(3),y_start(3),c12,c23,c13,c123,r1,r2,r3,r12,r23,r13,r123];
[C1 M1 C2 M2 C3 M3 E X1 Y1 X2 Y2 X3 Y3 norm] = findHalo3(index,beta0,x,y,e1,e2);