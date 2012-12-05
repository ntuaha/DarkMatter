function [C M e x y norm] = findHalo(i,beta0,show)
    file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
     [id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
     xx = [x' x'];
     yy = [y' y'];
     ee = [e1' e2'];
     galaxy(:,1) = xx;
     galaxy(:,2) = yy; 

         
     if show
        opt=optimset('MaxIter',1000,'MaxFunEvals',3000,'Display','iter');
     else
        opt=optimset('MaxIter',1000,'MaxFunEvals',3000);
     end
    [beta,norm] = lsqcurvefit(@darkmatter,beta0,galaxy,ee,[1e3,0,-1,0,0],[1e6,1e7,1,4200,4200],opt);
    C = beta(1);
    M = beta(2);
    e = beta(3);
    x = beta(4);
    y = beta(5);