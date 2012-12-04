clear;close;clc;


ansfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv';
[SkyId,numHalos,x_ref,y_ref,halo_x1,halo_y1,halo_x2,halo_y2,halo_x3,halo_y3]=textread(ansfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);
for i =1:300
    i
    file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
    
    [id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
    clear galaxy;
    xx = [x' x'];
    yy = [y' y'];
    ee = [e1' e2'];
    galaxy(:,1) = xx;
    galaxy(:,2) = yy;    
    c = 1000;
    M = 100000;
    e = 0.22;
    x_start = halo_x1(i)+1000;
    y_start = halo_y1(i)-1000;
    x_start = sum(x)/length(x);
    y_start = sum(y)/length(y);
    opts = statset('MaxIter',1000);
    [beta,r,J] = nlinfit(galaxy,ee,@darkmatter,[c,M,e,x_start,y_start],opts);
    
    e = e1.^2+e2.^2;
    if true
        bubbleplot(x,y,e,'blue',25);    
        hold on;
   
        plot(halo_x1(i),halo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        plot(beta(4),beta(5),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        plot(x_start,y_start,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);
    end
    beta
    dd(i) = getDistance(beta(4),beta(5),halo_x1(i),halo_y1(i))
    dd_start(i) = getDistance(x_start,y_start,halo_x1(i),halo_y1(i))
    %r
    
    
    
    
    if(i==1)
        break;                
    end
end
%sum(dd)/100
