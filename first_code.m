clear;close;clc;

guessfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Kriging.csv';
ansfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv';
[SkyId,numHalos,x_ref,y_ref,halo_x1,halo_y1,halo_x2,halo_y2,halo_x3,halo_y3]=textread(ansfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);
[gSkyId,gnumHalos,gx_ref,gy_ref,ghalo_x1,ghalo_y1,ghalo_x2,ghalo_y2,ghalo_x3,ghalo_y3]=textread(guessfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);

I = 1:100;
temp_norm(I) = 1e4;
temp_dd(I) = 1e4;
temp_dd_norm(I) = 1e4;
temp_dd_x(I) = 0.0;
temp_dd_y(I) = 0.0;
result_x(I) = 0.0;
result_y(I) = 0.0;
dd(I) = 0.0;
dd_start(I) = 0.0;
show = false;
if matlabpool('size') <4 % checking to see if my pool is already open
    matlabpool open 4
end



parfor i =1:100
    i
    


    %file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
    
    %[id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
    %clear galaxy;
    %xx = [x' x'];
    %yy = [y' y'];
    %ee = [e1' e2'];
    %galaxy(:,1) = xx;
    %galaxy(:,2) = yy;   
    temp_x = 4500;
    temp_y = 4500;
    x_start = floor(halo_x1(i)/100)*100;
    y_start = floor(halo_y1(i)/100)*100;
    %x_start = 2100;
    %y_start = 2100;
    %for x_start=0:100:4200
    %for y_start=0:100:4200
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
            %[beta,norm,J] = nlinfit(galaxy,ee,@darkmatter,[c,M,e,x_start,y_start],opts);
%             if show
%                 opt=optimset('MaxIter',1000,'MaxFunEvals',3000,'Display','iter');
%             else
%                 opt=optimset('MaxIter',1000,'MaxFunEvals',3000);
%             end
%             [beta(:,i),norm] = lsqcurvefit(@darkmatter,[c,M,e,x_start,y_start],galaxy(:,:,i),ee(:,i),[1e3,0,-1,0,0],[1e6,1e7,1,4200,4200],opt);
            [tempC tempM tempE XX YY norm] = findHalo(i,[c,M,e,x_start,y_start],show);
            if(norm<temp_norm(i))
                temp_norm(i) = norm;
                temp_x = XX;
                temp_y = YY;
            end
            temp = getDistance(XX,YY,halo_x1(i),halo_y1(i));
            if temp<temp_dd(i)
                temp_dd(i) = temp;
                temp_dd_x(i) = XX;
                temp_dd_y(i) = YY;
                temp_dd_norm(i) = norm;
            end
        end
     end

        result_x(i) = temp_x;
        result_y(i) = temp_y;
        dd(i) = getDistance(result_x(i),result_y(i),halo_x1(i),halo_y1(i));
        dd_start(i) = getDistance(x_start,y_start,halo_x1(i),halo_y1(i));
        %dd_start(i) = getDistance( sum(x)/length(x),sum(y)/length(y),halo_x1(i),halo_y1(i));
       
    if show
        bubbleplot(x,y,e1.^2+e2.^2,'blue',25);    
        hold on; 
        plot(halo_x1(i),halo_y1(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
        plot(result_x(i),result_y(i),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        %plot(sum(x)/length(x),sum(y)/length(y),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);
        %dd_start(i)
        dd(i);
        temp_norm(i);
    end
    

    
    
    
    

end
matlabpool close;



fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/1.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=1:100
    fprintf(fp,'Sky%d,%f,%f,0.0,0.0,0.0,0.0\n',i,result_x(i),result_y(i));
end
fclose(fp);


fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/2.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_d,pred_norm,best_x1,best_y1,best_norm,best_norm\n');
for i=1:100
    fprintf(fp,'Sky%d,%f,%f,%f,%f,%f,%f,%f,%f\n',i,result_x(i),result_y(i),dd(i),temp_norm(i),temp_dd_x(i),temp_dd_y(i),temp_dd_norm(i),temp_dd(i));
end
fclose(fp);

fp = fopen('/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/3.csv','w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=1:100
    fprintf(fp,'Sky%d,%f,%f,0.0,0.0,0.0,0.0\n',i,temp_dd_x(i),temp_dd_y(i));
end
fclose(fp);

score = sum(dd)/100/1000;
score = sum(temp_dd)/100/1000;

