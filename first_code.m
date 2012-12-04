clear;close;clc;


ansfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Training_halos.csv';
[SkyId,numHalos,x_ref,y_ref,halo_x1,halo_y1,halo_x2,halo_y2,halo_x3,halo_y3]=textread(ansfile,'%s%d%n%n%n%n%n%n%n%n','delimiter', ',','headerlines',1);
for i =1:300
    
    file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
    
    [id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
    
    e = e1.^2+e2.^2;
    %surf(x,y,e);
    %hold on;
    bubbleplot(x,y,e,'blue',25);    
    hold on;
    plot(halo_x1(i),halo_y1(i),'ro');
    break;
            
    
end
