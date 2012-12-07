function  [C M E temp_x temp_y temp_norm x y e1 e2]=subfunction(step,i)
temp_norm = 1e4;
file = ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/data/Train_Skies/Training_Sky' num2str(i) '.csv' ];
[id,x,y,e1,e2]=textread(file,'%s%n%n%n%n','delimiter', ',','headerlines',1);
length(e2)
for j = 0:step:4200
    for k = 0:step:4200
        i
        j
        k
        c = 1000;
        M = 1;
        e = 0;

        x_start = j;
        y_start = k;
        [tempC tempM tempE XX YY norm] = findHalo4(i,[c,M,e,x_start,y_start],x,y,e1,e2);
        if(norm<temp_norm)
            temp_norm = norm;
            temp_x = XX;
            temp_y = YY;
            C = tempC;
            E = tempE;
            M = tempM;
        end
        
    end
end
    