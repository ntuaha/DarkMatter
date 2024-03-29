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

show = true;
if matlabpool('size') <4 % checking to see if my pool is already open
    matlabpool open 4
end

step = 100

parfor i =I
    
    
    %     temp_x = 4500;
    %     temp_y = 4500;
    %     x_start = floor(halo_x1(i)/100)*100;
    %     y_start = floor(halo_y1(i)/100)*100;
    %     for j = 0:step:4200
    %         for k = 0:step:4200
    %              i
    %              j
    %              k
    %              c = 1000;
    %              M = 1;
    %              e = 0;
    %              x_start = j;
    %              y_start = k;
    %             [tempC tempM tempE XX YY norm] = findHalo(i,[c,M,e,x_start,y_start],false);
    %             if(norm<temp_norm(i))
    %                 temp_norm(i) = norm;
    %                 temp_x = XX;
    %                 temp_y = YY;
    %             end
    %             temp = getDistance(XX,YY,halo_x1(i),halo_y1(i));
    %             if temp<temp_dd(i)
    %                 temp_dd(i) = temp;
    %                 temp_dd_x(i) = XX;
    %                 temp_dd_y(i) = YY;
    %                 temp_dd_norm(i) = norm;
    %             end
    %         end
    %      end
    %
    [C M E result_x(i) result_y(i) temp_norm(i) x y e1 e2]=subfunction(step,i);
    dd(i) = getDistance(result_x(i),result_y(i),halo_x1(i),halo_y1(i));
    if(numHalos(i)>5)
        halo_x = result_x(i);
        halo_y = result_y(i);    
        halo_r = sqrt((x-halo_x).^2 + (y-halo_y).^2);
        phi = atan((y-halo_y)./(x-halo_x));
        e1  = e1 + M./(halo_r+C) .* cos(2*phi);
        e2  = e2 + M./(halo_r+C) .* sin(2*phi);   
        [C M E result_x_2(i) result_y_2(i) temp_norm_2(i)]=subfunction2(step,i,x,y,e1,e2,C,M,E);  
        dd(i) = getTotalDistance([result_x(i) result_x_2(i)],[result_y(i) result_y_2(i)],[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)]);
    end
    
    
    if show
        
        plot(halo_x1(i),halo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        hold on
        axis([0 4200 0 4200]);
        text(halo_x1(i),halo_y1(i),'r1');
        plot(result_x(i),result_y(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        text(result_x(i),result_y(i),'n1');
        plot(ghalo_x1(i),ghalo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
        h = text(ghalo_x1(i),ghalo_y1(i),'g1');
        
        if(numHalos(i)>1)
            plot(halo_x2(i),halo_y2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
            text(halo_x2(i),halo_y2(i),'r2');
            plot(result_x_2(i),result_y_2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
            text(result_x_2(i),result_y_2(i),'n2');
            plot(ghalo_x2(i),ghalo_y2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
            h = text(ghalo_x2(i),ghalo_y2(i),'g2');
        end
        
             
        saveas(h, ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/figure/twohalo/' num2str(i) '.png'],'png');
        close;
    end
    
    
    
    
    
    
    
end
matlabpool close;



fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/twohalo/1.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,0.0,0.0\n',i,result_x(i),result_y(i),result_x_2(i),result_y_2(i));
end
fclose(fp);


fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/twohalo/2.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_d,pred_norm,best_x1,best_y1,best_norm,best_norm\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,%f,%f,%f,%f\n',i,result_x(i),result_y(i),dd(i),temp_norm(i),temp_dd_x(i),temp_dd_y(i),temp_dd_norm(i),temp_dd(i));
end
fclose(fp);

fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/twohalo/3.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,0.0,0.0\n',i,temp_dd_x(i),temp_dd_y(i),temp_dd_x_2(i),temp_dd_y_2(i));
end
fclose(fp);
K = I;
score = sum(dd(K))/length(K)/1000
score2 = sum(temp_dd(K))/length(K)/1000
