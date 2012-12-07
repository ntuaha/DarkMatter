function [C M e x y x2 y2 norm] = findHalo2(i,beta0,show,x,y,e1,e2)
    
     xx = [x' x'];
     yy = [y' y'];
     ee = [e1' e2'];
     galaxy(:,1) = xx;
     galaxy(:,2) = yy; 


     if show
        bubbleplot(x,y,e1.^2+e2.^2,'blue',25);    
        hold on;
        opt=optimset('MaxIter',1000,'MaxFunEvals',3000,'Display','iter');
     else
        opt=optimset('MaxIter',1000,'MaxFunEvals',3000);
     end
     
     %model 2
     %[beta,norm,J] = nlinfit(galaxy,ee,@darkmatter,[c,M,e,x_start,y_start],opts);
     %model 1
    [beta,norm] = lsqcurvefit(@darkmatter2,beta0,galaxy,ee,[1e3,0,-1,0,0,0,0],[1e6,1e7,1,4200,4200,4200,4200],opt);
    C = beta(1);
    M = beta(2);
    e = beta(3);
    x = beta(4);
    y = beta(5);
    x2 = beta(6);
    y2 = beta(7);