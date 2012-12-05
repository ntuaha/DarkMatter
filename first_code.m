clear;close;clc;

guessfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Kriging.csv';
ansfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv';
[SkyId,numHalos,x_ref,y_ref,halo_x1,halo_y1,halo_x2,halo_y2,halo_x3,halo_y3]=textread(ansfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);
[gSkyId,gnumHalos,gx_ref,gy_ref,ghalo_x1,ghalo_y1,ghalo_x2,ghalo_y2,ghalo_x3,ghalo_y3]=textread(guessfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);
for i =1:100
    i
    file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
    
    [id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
    clear galaxy;
    xx = [x' x'];
    yy = [y' y'];
    ee = [e1' e2'];
    galaxy(:,1) = xx;
    galaxy(:,2) = yy;   
    temp_x = 4500;
    temp_y = 4500;
    temp_norm(i) = 1e4;

     x_start = floor(halo_x1(i)/100)*100;
     y_start = floor(halo_y1(i)/100)*100;
     %for x_start=0:100:4200
     %   for y_start=0:100:4200
    %x_start = ghalo_x1(i);
    %y_start = ghalo_y1(i);
    for j = 0:50:4200
        for k = 0:50:4200

             c = 1000;
             M = 1;
             e = 0;
             x_start = j;
             y_start = k;
             %x_start = 2100;
             %y_start = 2100;




            %opts = statset('MaxIter',50,'Display','iter');
            opts = statset('MaxIter',100);
            %[beta,norm,J] = nlinfit(galaxy,ee,@darkmatter,[c,M,e,x_start,y_start],opts);
            [beta,norm] = lsqcurvefit(@darkmatter,[c,M,e,x_start,y_start],galaxy,ee);
            if(norm<temp_norm(i))
                temp_norm(i) = norm;
                temp_x = beta(4);
                temp_y = beta(5);
           end
        end
     end
    %    end
    %end
        result_x = temp_x;
        result_y = temp_y;
        dd(i) = getDistance(temp_x,temp_y,halo_x1(i),halo_y1(i));
        dd_start(i) = getDistance(x_start,y_start,halo_x1(i),halo_y1(i));
        %dd_start(i) = getDistance( sum(x)/length(x),sum(y)/length(y),halo_x1(i),halo_y1(i));
       
    if false
        e = e1.^2+e2.^2;
        bubbleplot(x,y,e,'blue',25);    
        hold on; 
        plot(halo_x1(i),halo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        plot(beta(4),beta(5),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        plot(sum(x)/length(x),sum(y)/length(y),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);
        %dd_start(i)
        dd(i)
        c = beta(1);
        M = beta(2);
        e = beta(3);
        temp_norm(i)
    end
    

    %r
    
    
    
    

end
sum(dd)/1

