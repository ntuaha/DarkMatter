function [C1 M1 C2 M2 C3 M3 E X1 Y1 X2 Y2 X3 Y3 norm] = findHalo3(index,beta0,x,y,e1,e2)

xx = [x' x'];
yy = [y' y'];
ee = [e1' e2'];
galaxy(:,1) = xx;
galaxy(:,2) = yy;





opt=optimset('MaxIter',3000,'MaxFunEvals',length(xx),'TolFun',1e-10);

c1 = -1;
c2 = 2;

lower_beta = [1.0,0,1.0,0,1.0,0,-1,0,0,0,0,0,0,1,1,1,1,c1,c1,c1,c1,c1,c1,c1];
upper_beta = [1e6,1e7,1e6,1e7,1e6,1e7,1,4200,4200,4200,4200,4200,4200,1e10,1e10,1e10,1e10,c2,c2,c2,c2,c2,c2,c2];

[beta,norm] = lsqcurvefit(@darkmatter3,beta0,galaxy,ee,lower_beta,upper_beta,opt);
C1 = beta(1);
M1 = beta(2);
C2 = beta(3);
M2 = beta(4);
C3 = beta(5);
M3 = beta(6);
E = beta(7);
X1 = beta(8);
Y1 = beta(9);
X2 = beta(10);
Y2= beta(11);
X3 = beta(12);
Y3= beta(13);