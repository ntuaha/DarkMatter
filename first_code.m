clear;close;clc;
for i =1:300
    file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
    [id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
    
    break;    
end
