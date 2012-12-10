function [C M e halo_x halo_y norm] = findHalo4(i,beta0,x,y,e1,e2)

xx = [x' x'];
yy = [y' y'];
ee = [e1' e2'];
galaxy(:,1) = xx;
galaxy(:,2) = yy;



opt=optimset('MaxIter',1000,'MaxFunEvals',3000);
[beta,norm] = lsqcurvefit(@darkmatter1,beta0,galaxy,ee,[1e3,0,-1,0,0],[1e6,1e7,1,4200,4200],opt);
C = beta(1);
M = beta(2);
e = beta(3);
halo_x = beta(4);
halo_y = beta(5);