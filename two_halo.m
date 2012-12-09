clear;close;clc;

guessfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Kriging_Training/Kriging.csv';
ansfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv';
[SkyId,numHalos,x_ref,y_ref,halo_x1,halo_y1,halo_x2,halo_y2,halo_x3,halo_y3]=textread(ansfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);
[gSkyId,ghalo_x1,ghalo_y1,ghalo_x2,ghalo_y2,ghalo_x3,ghalo_y3]=textread(guessfile,'%s%n%n%n%n%n%n','delimiter', ',','headerlines',1);

I = 1:300;
temp_norm(I) = 1e4;
result_x(I) = 0.0;
result_y(I) = 0.0;

result_x_2(I) = 0.0;
result_y_2(I) = 0.0;
result_x_3(I) = 0.0;
result_y_3(I) = 0.0;



dd(I) = 0.0;

show = true;
if matlabpool('size') <6 % checking to see if my pool is already open
    matlabpool open 6
end

step = 500;
datafile = 'twohalo_4';
real_run = 101:110;
parfor i =real_run
    file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
    [id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
    [C M E result_x(i) result_y(i) temp_norm(i)]=subfunction3(step,i,datafile,[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)],x,y,e1,e2);
    dd(i) = getDistance(result_x(i),result_y(i),halo_x1(i),halo_y1(i));
    %if(numHalos(i)>1)
    %    result_x_2(i) = 2100.0;
    %    result_y_2(i) = 2100.0;
    %end
    if(numHalos(i)>2)
        result_x_3(i) = 2100.0;
        result_y_3(i) = 2100.0;
    end
     if(numHalos(i)>1)
         halo_x = result_x(i);
         halo_y = result_y(i);    
%         halo_r = sqrt((x-halo_x).^2 + (y-halo_y).^2);
%         phi = atan((y-halo_y)./(x-halo_x));
%         e1  = e1 + M./(halo_r+C) .* cos(2*phi);
%         e2  = e2 + M./(halo_r+C) .* sin(2*phi);   
         [C M E result_x_2(i) result_y_2(i) temp_norm(i)]=subfunction5(step,i,datafile,[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)],x,y,e1,e2,result_x(i),result_y(i),C,M,E);
%          area=[1000:step:3000;1000:step:3000]';
%         [C M E result_x(i) result_y(i) temp_norm(i)]=subfunction6(area,step,i,datafile,[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)],x,y,e1,e2);
         dd(i) = getTotalDistance([result_x(i) result_x_2(i)],[result_y(i) result_y_2(i)],[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)]);
     end
%     
    
    if show
        
        plot(halo_x1(i),halo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        hold on
        axis([0 4200 0 4200]);
        text(halo_x1(i),halo_y1(i),'r1');
        plot(result_x(i),result_y(i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        text(result_x(i),result_y(i),'n1');
        plot(ghalo_x1(i),ghalo_y1(i),'r.', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
        h = text(ghalo_x1(i),ghalo_y1(i),'g1');
        
        if(numHalos(i)>1)
            plot(halo_x2(i),halo_y2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
            text(halo_x2(i),halo_y2(i),'r2');
            plot(result_x_2(i),result_y_2(i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
            text(result_x_2(i),result_y_2(i),'n2');
            plot(ghalo_x2(i),ghalo_y2(i),'r.', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
            h = text(ghalo_x2(i),ghalo_y2(i),'g2');
        end
        
       if(numHalos(i)>2)
            plot(halo_x3(i),halo_y3(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
            text(halo_x3(i),halo_y3(i),'r3');
            plot(result_x_3(i),result_y_3(i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
            text(result_x_3(i),result_y_3(i),'n3');
            plot(ghalo_x3(i),ghalo_y3(i),'r.', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
            h = text(ghalo_x3(i),ghalo_y3(i),'g3');
        end
        
             
        saveas(h, ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/figure/' datafile '/' num2str(i) '.png'],'png');
        close;
    end
    
    
    
    
    
    
    
end
matlabpool close;



fp = fopen(['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/' datafile '/1.csv'],'w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,%f,%f\n',i,result_x(i),result_y(i),result_x_2(i),result_y_2(i),result_x_3(i),result_y_3(i));
end
fclose(fp);


K = real_run;
score = sum(dd(K))/length(K)/1000
