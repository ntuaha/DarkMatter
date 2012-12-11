clear;close;clc;

guessfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Kriging_Training/Kriging.csv';
ansfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv';
[SkyId,numHalos,x_ref,y_ref,halo_x1,halo_y1,halo_x2,halo_y2,halo_x3,halo_y3]=textread(ansfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);
[gSkyId,ghalo_x1,ghalo_y1,ghalo_x2,ghalo_y2,ghalo_x3,ghalo_y3]=textread(guessfile,'%s%n%n%n%n%n%n','delimiter', ',','headerlines',1);

wushfile = '/Users/aha/Desktop/rstudio-export/non-param.train.7.csv';
[wSkyId,whalo_x1,whalo_y1,whalo_x2,whalo_y2,whalo_x3,whalo_y3]=textread(wushfile,'%s%n%n%n%n%n%n','delimiter', ',','headerlines',1);





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
mytime = clock();
datafile = ['wush_nonp_7' num2str(mytime(2)) '-' num2str(mytime(3)) '-' num2str(mytime(4)) '-' num2str(mytime(5)) '-' num2str(floor(mytime(6)))];

s = mkdir(['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/new_version_special/figure/' datafile '/']);
if(s(1)~=1)
    exit();
end
s = mkdir(['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/new_version_special/data/' datafile '/']);
if(s(1)~=1)
    exit();
end

%Make random start
rrange = 0;
rx_start(1:3,I) = 0;
ry_start(1:3,I) = 0;
for i=1:300
    rx_start(1,i) = whalo_x1(i);
    ry_start(1,i) = whalo_y1(i);
    if (numHalos(i)>1)
        rx_start(2,i) = whalo_x2(i);
        ry_start(2,i) = whalo_y2(i);
        
    end
    if (numHalos(i)>2)
        rx_start(3,i) = whalo_x3(i);
        ry_start(3,i) = whalo_y3(i);
        
    end
end


real_run = 1:300;
parfor i =real_run
    
    
    
    
    
    file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
    [id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
    if(numHalos(i)==1)
        [C M E result_x(i) result_y(i) temp_norm(i)]=subfunction1(step,i,x,y,e1,e2,[rx_start(1,i)],[ry_start(1,i)]);
        dd(i) = getDistance(result_x(i),result_y(i),halo_x1(i),halo_y1(i));
    end
    
    if(numHalos(i)==2)
        [C1 M1 C2 M2 E result_x(i) result_y(i) result_x_2(i) result_y_2(i) temp_norm(i)]=subfunction2(step,i,x,y,e1,e2,[rx_start(1,i) rx_start(2,i)],[ry_start(1,i) ry_start(2,i)]);
        dd(i) = getTotalDistance([result_x(i) result_x_2(i)],[result_y(i) result_y_2(i)],[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)]);
    end
    if(numHalos(i)==3)
        %[C1 M1 C2 M2 E result_x(i) result_y(i) result_x_2(i) result_y_2(i) temp_norm(i)]=subfunction2(step,i,x,y,e1,e2,[rx_start(1,i) rx_start(2,i)],[ry_start(1,i) ry_start(2,i)]);
        %dd(i) = getTotalDistance([result_x(i) result_x_2(i)],[result_y(i) result_y_2(i)],[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)]);
        [C1 M1 C2 M2 C3 M3 E result_x(i) result_y(i) result_x_2(i) result_y_2(i) result_x_3(i) result_y_3(i) temp_norm(i)]=subfunction3(step,i,x,y,e1,e2,[rx_start(1,i) rx_start(2,i) rx_start(3,i)],[ry_start(1,i) ry_start(2,i) ry_start(3,i)]);
        dd(i) = getTotalDistance([result_x(i) result_x_2(i) result_x_3(i)],[result_y(i) result_y_2(i) result_y_3(i)],[halo_x1(i) halo_x2(i) halo_x3(i)],[halo_y1(i) halo_y2(i) halo_y3(i)]);
    end
    
    %
    
    if show
        
        plot(halo_x1(i),halo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        hold on
        axis([0 4200 0 4200]);
        text(halo_x1(i),halo_y1(i),'r1');
        plot(result_x(i),result_y(i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        text(result_x(i),result_y(i),'n1');
        plot(rx_start(1,i),ry_start(1,i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
        h = text(rx_start(1,i),ry_start(1,i),'g1');
        
        if(numHalos(i)>1)
            plot(halo_x2(i),halo_y2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
            text(halo_x2(i),halo_y2(i),'r2');
            plot(result_x_2(i),result_y_2(i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
            text(result_x_2(i),result_y_2(i),'n2');
            plot(rx_start(2,i),ry_start(2,i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
            h = text(rx_start(2,i),ry_start(2,i),'g2');
        end
        
        if(numHalos(i)>2)
            plot(halo_x3(i),halo_y3(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
            text(halo_x3(i),halo_y3(i),'r3');
            plot(result_x_3(i),result_y_3(i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
            text(result_x_3(i),result_y_3(i),'n3');
            plot(rx_start(3,i),ry_start(3,i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
            h = text(rx_start(3,i),ry_start(3,i),'g3');
        end
        
        
        saveas(h, ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/new_version_special/figure/' datafile '/' num2str(i) '.png'],'png');
        close;
    end
    
    
    
    
    
    
    
end
matlabpool close;



fp = fopen(['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/new_version_special/data/' datafile '/1.csv'],'w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,%f,%f\n',i,result_x(i),result_y(i),result_x_2(i),result_y_2(i),result_x_3(i),result_y_3(i));
end
fclose(fp);

fp = fopen(['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/new_version_special/data/' datafile '/random.csv'],'w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,%f,%f\n',i,rx_start(1,i),ry_start(1,i),rx_start(2,i),ry_start(2,i),rx_start(3,i),ry_start(3,i));
end
fclose(fp);


K = real_run;
score = sum(dd(K))/length(K)/1000
