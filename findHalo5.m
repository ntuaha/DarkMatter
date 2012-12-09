function [C M e halo_x halo_y norm] = findHalo5(i,beta0,x,y,e1,e2,x1,y1,C1,M1,E1)

xx = [x' x'];
yy = [y' y'];
ee = [e1' e2'];
galaxy(:,1) = xx;
galaxy(:,2) = yy;
L = length(xx);
galaxy(1:L,3) = x1;
galaxy(1:L,4) = y1;
galaxy(1:L,5) = C1;
galaxy(1:L,6) = M1;
galaxy(1:L,7) = E1;



opt=optimset('MaxIter',1000,'MaxFunEvals',3000);


%model 2
%[beta,norm,J] = nlinfit(galaxy,ee,@darkmatter,[c,M,e,x_start,y_start],opts);
%model 1
[beta,norm] = lsqcurvefit(@darkmatter3,beta0,galaxy,ee,[1.0,0,-0.22,0,0,1,-0.22],[1e6,M1,0.22,4200,4200,50,0.22],opt);
C = beta(1);
M = beta(2);
e = beta(3);
halo_x = beta(4);
halo_y = beta(5);