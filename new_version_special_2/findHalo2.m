function [C1 M1 C2 M2 E X1 Y1 X2 Y2 norm] = findHalo2(index,beta0,x,y,e1,e2)

xx = [x' x'];
yy = [y' y'];
ee = [e1' e2'];
galaxy(:,1) = xx;
galaxy(:,2) = yy;


c1 = -1e4;
c2 = 1e4;

e2_upper = 1;
e2_lower = -1;

L_min = -4200;
L_max = 8400;

opt=optimset('MaxIter',3000,'MaxFunEvals',length(xx),'TolFun',1e-12);

lower_beta = [1.0,0,1.0,0,-1,L_min,L_min,L_min,L_min,1,c1,c1,c1,e2_lower];
upper_beta = [1e6,1e7,1e6,1e7,1,L_max,L_max,L_max,L_max,1e10,c2,c2,c2,e2_upper];


[beta,norm] = lsqcurvefit(@darkmatter2,beta0,galaxy,ee,lower_beta,upper_beta,opt);

C1 = beta(1);
M1 = beta(2);
C2 = beta(3);
M2 = beta(4);
E = beta(5);
X1 = beta(6);
Y1 = beta(7);
X2 = beta(8);
Y2 = beta(9);