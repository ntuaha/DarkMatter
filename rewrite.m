clear;close;clc;



datafile = 'twohalo_test'

guessfile = '/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/lenstool.benchmark.csv';
ansfile = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/' datafile '/test.csv'];
[SkyId,halo_x1,halo_y1,halo_x2,halo_y2,halo_x3,halo_y3]=textread(ansfile,'%s%n%n%n%n%n%n','delimiter', ',','headerlines',1);
[gSkyId,ghalo_x1,ghalo_y1,ghalo_x2,ghalo_y2,ghalo_x3,ghalo_y3]=textread(guessfile,'%s%n%n%n%n%n%n','delimiter', ',','headerlines',1);

close
i = 102

plot(ghalo_x1(i),ghalo_y1(i),'rx', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
        hold on
        axis([0 4200 0 4200]);
        
        
        
        plot(ghalo_x2(i),ghalo_y2(i),'r+', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
         plot(ghalo_x3(i),ghalo_y3(i),'r+', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
         plot(halo_x1(i),halo_y1(i),'ro', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
         text(halo_x1(i)+100,halo_y1(i),'1')


fp = fopen(['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/data/' datafile '/test2.csv'],'w+');
fprintf(fp,'SkyId,pred_x1,pred_y1,pred_x2,pred_y2,pred_x3, pred_y3\n');
for i=1:120
    fprintf(fp,'Sky%d,%f,%f,%f,%f,%f,%f\n',i,halo_x1(i),halo_y1(i),ghalo_x2(i),ghalo_y2(i),ghalo_x3(i),ghalo_y3(i));
end
fclose(fp);

