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

temp_norm_2(I) = 1e4;
temp_dd_x_2(I) = 0.0;
temp_dd_y_2(I) = 0.0;
result_x_2(I) = 0.0;
result_y_2(I) = 0.0;


dd(I) = 0.0;
dd_start(I) = 0.0;
show = true;
if matlabpool('size') <4 % checking to see if my pool is already open
    matlabpool open 4
end


step = 100;

for i =101:101
    i
    temp_x = 4500;
    temp_y = 4500;
    temp_x_2 = 4500;
    temp_y_2 = 4500;
    %x_start = floor(halo_x1(i)/100)*100;
    %y_start = floor(halo_y1(i)/100)*100;
    %x_start = 2100;
    %y_start = 2100;
    %for x_start=0:100:4200
    %for y_start=0:100:4200
    %x_start = ghalo_x1(i);
    %y_start = ghalo_y1(i);
    count = 0;
    for j = 0:1000:4200
        for k = 0:1000:4200
            count = count+1
             c = 1000;
             M = 1;
             e = 0;
             x_start = j;
             y_start = k;
             %x_start = ghalo_x1(i);
             %y_start = ghalo_x1(i);
            [tempC tempM tempE XX YY norm] = findHalo(i,[c,M,e,x_start,y_start],false);
            if(norm<temp_norm(i))
                if(getDistance(XX,YY,temp_x,temp_y)>100 && numHalos(i)>1 && norm < temp_norm_2(i))
                    temp_norm_2(i) = temp_norm(i);                    
                    temp_x_2 = temp_x;
                    temp_y_2 = temp_y;
                end
                    
                temp_norm(i) = norm;
                temp_x = XX;
                temp_y = YY;
                
                    
            elseif(norm < temp_norm_2(i))
                temp_norm_2(i) = norm;
                temp_x_2 = XX;
                temp_y_2 = YY;   
            end
                    

        end
     end

        result_x(i) = temp_x;
        result_y(i) = temp_y;
        result_x2(i) = temp_x_2;
        result_y2(i) = temp_y_2;
        dd(i) = getTotalDistance([temp_x temp_x_2],[temp_y temp_y_2] ,[halo_x1(i) halo_x2(i)],[halo_y1(i) halo_y2(i)]);
        
       
    if show
        plot(halo_x1(i),halo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        hold on;
        axis([0 4200 0 4200]);
        text(halo_x1(i),halo_y1(i),'r1');
        plot(halo_x2(i),halo_y2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        text(halo_x2(i),halo_y2(i),'r2');
        plot(result_x(i),result_y(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        text(result_x(i),result_y(i),'n1');
        plot(result_x_2(i),result_y_2(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        text(result_x_2(i),result_y_2(i),'n2');
        plot(ghalo_x1(i),ghalo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
        h = text(ghalo_x1(i),ghalo_y1(i),'g1');

        %plot(sum(x)/length(x),sum(y)/length(y),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);)
        saveas(h, ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/figure/updateSingle_2/' num2str(i) '.png'],'png');                          
        close;
    end
    

    
    
    
    

end
matlabpool close;


K = I;
fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/updateSingle_2/1.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,0.0,0.0\n',i,result_x(i),result_y(i),result_x_2(i),result_y_2(i));
end
fclose(fp);


fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/updateSingle_2/2.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_d,pred_norm,best_x1,best_y1,best_norm,best_norm\n');
for i=K
    fprintf(fp,'Sky%d,%f,%f,%f,%f,%f,%f,%f,%f\n',i,result_x(i),result_y(i),dd(i),temp_norm(i),temp_dd_x(i),temp_dd_y(i),temp_dd_norm(i),temp_dd(i));
end
fclose(fp);

fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/updateSingle_2/3.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=I
    fprintf(fp,'Sky%d,%f,%f,%f,%f,0.0,0.0\n',i,temp_dd_x(i),temp_dd_y(i),temp_dd_x_2(i),temp_dd_y_2(i));
end
fclose(fp);

score = sum(dd)/100/1000;
score = sum(temp_dd)/100/1000;

