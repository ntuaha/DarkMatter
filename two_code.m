clear;close;clc;

guessfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Kriging_Training/Kriging.csv';
ansfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv';
[SkyId,numHalos,x_ref,y_ref,halo_x1,halo_y1,halo_x2,halo_y2,halo_x3,halo_y3]=textread(ansfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);
[gSkyId,ghalo_x1,ghalo_y1,ghalo_x2,ghalo_y2,ghalo_x3,ghalo_y3]=textread(guessfile,'%s%n%n%n%n%n%n','delimiter', ',','headerlines',1);

I = 1:200;
temp_norm(I) = 1e4;
temp_dd(I) = 1e4;
temp_dd_norm(I) = 1e4;
temp_dd_x(I) = 0.0;
temp_dd_y(I) = 0.0;
result_x(I) = 0.0;
result_y(I) = 0.0;

temp_dd_x_2(I) = 0.0;
temp_dd_y_2(I) = 0.0;
result_x_2(I) = 0.0;
result_y_2(I) = 0.0;



dd(I) = 0.0;
dd_start(I) = 0.0;

  if matlabpool('size') <4 % checking to see if my pool is already open
      matlabpool open 4
  end

resolution = 150;
show = true;
parfor i =101:200
    i
    temp_x = 4500;
    temp_y = 4500;
    x_start = floor(halo_x1(i)/resolution)*resolution+500*rand();
    y_start = floor(halo_y1(i)/resolution)*resolution+500*rand();
    x_start_2 = floor(halo_x2(i)/resolution)*resolution+500*rand();
    y_start_2 = floor(halo_y2(i)/resolution)*resolution+500*rand();
    x_start_3 = floor(halo_x3(i)/resolution)*resolution+500*rand();
    y_start_3 = floor(halo_y3(i)/resolution)*resolution+500*rand();
    %x_start = ghalo_x1(i);
    %y_start = ghalo_y1(i);
    time = 0;
    %for j = 0:500:4200
    %    for k = 0:500:4200
        time = time+1
             c = 1000;
             M = 1;
             e = 0;
             %x_start = ghalo_x1(i);
             %y_start = ghalo_y1(i);
             %x_start_2 = ghalo_x2(i);
             %y_start_2 = ghalo_x2(i);
             %x_start = 2100;
             %y_start = 2100;

        
            [tempC tempM tempE XX YY XX2 YY2 norm] = findHalo2(i,[c,M,e,x_start,y_start,x_start_2,y_start_2],show);
            if(norm<temp_norm(i))
                temp_norm(i) = norm;
                temp_x = [XX XX2];
                temp_y = [YY YY2];
            end
            temp = getTotalDistance([XX XX2],[YY YY2] ,[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)]);
            if temp<temp_dd(i)
                temp_dd(i) = temp;
                temp_dd_x(i) = XX;
                temp_dd_y(i) = YY;
                temp_dd_x_2(i) = XX2;
                temp_dd_y_2(i) = YY2;
                temp_dd_norm(i) = norm;
            end
     %   end
     %end

        result_x(i) = temp_x(1);
        result_y(i) = temp_y(1);
        result_x_2(i) = temp_x(2);
        result_y_2(i) = temp_y(2);
        dd(i) = getTotalDistance([result_x(i) result_x_2(i)],[result_y(i) result_y_2(i)],[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)]);
        %dd_start(i) = getDistance(x_start,y_start,halo_x1(i),halo_y1(i));
       
    if show 
        plot(halo_x1(i),halo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        text(halo_x1(i),halo_y1(i),'r1');
        plot(halo_x2(i),halo_y2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        text(halo_x2(i),halo_y2(i),'r2');
        plot(result_x(i),result_y(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        text(result_x(i),result_y(i),'n1');
        plot(result_x_2(i),result_y_2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        text(result_x_2(i),result_y_2(i),'n2');
        plot(ghalo_x1(i),ghalo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
        text(ghalo_x1(i),ghalo_y1(i),'g1');
        plot(ghalo_x2(i),ghalo_y2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
        h = text(ghalo_x2(i),ghalo_y2(i),'g2');
        %plot(sum(x)/length(x),sum(y)/length(y),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);)
        saveas(h, ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/figure/' num2str(i) '.png'],'png');                          
        close;
        
    end
    

    
    
    
    

end
 matlabpool close;



fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/1.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,0.0,0.0\n',i,result_x(i),result_y(i),result_x_2(i),result_y_2(i));
end
fclose(fp);


fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/2.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_d,pred_norm,best_x1,best_y1,best_norm,best_norm\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,%f,%f,%f,%f\n',i,result_x(i),result_y(i),dd(i),temp_norm(i),temp_dd_x(i),temp_dd_y(i),temp_dd_norm(i),temp_dd(i));
end
fclose(fp);

fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/3.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,0.0,0.0\n',i,temp_dd_x(i),temp_dd_y(i),temp_dd_x_2(i),temp_dd_y_2(i));
end
fclose(fp);
K = 101:200;
score = sum(dd(K))/100/1000
score2 = sum(temp_dd(K))/100/1000

