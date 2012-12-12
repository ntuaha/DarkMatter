function  [C1 M1 C2 M2 E X1 Y1 X2 Y2 norm]=subfunction2(step,index, x,y,e1,e2,x_start,y_start)

c1 = 1000;
m1 = 1;
c2 = 1000;
m2 = 1;
e = 0;
c12 = 1e6;
r1 = 1;
r2 = 1;
r12 = 1;
E2 = 0;


step = 200;
temp_X1 =0;
temp_Y1 =0;
temp_X2 =0;
temp_Y2 =0;
temp_norm = 1e4;
temp_length = 1e5;
max_area = step*1.41459*0.5;
for XX2 = 0:step:4200
    for YY2 = 0:step:4200
        XX2
        YY2
        %first
        beta0 = [c1,m1,c2,m2,e,x_start(1),y_start(1),XX2,YY2,c12,r1,r2,r12,E2];
        [C1 M1 C2 M2 E X1 Y1 XXX2 YYY2 norm] = findHalo2(index,beta0,x,y,e1,e2);
        %second
        beta0 = [c1,m1,c2,m2,e,x_start(1),y_start(1),XXX2,YYY2,c12,r1,r2,r12,E2];
        [C1 M1 C2 M2 E X1 Y1 final_X2 final_Y2 norm] = findHalo2(index,beta0,x,y,e1,e2);
        %third
%         beta0 = [c1,m1,c2,m2,e,x_start(1),y_start(1),temp_XXX2,temp_YYY2,c12,r1,r2,r12,E2];
%         [C1 M1 C2 M2 E X1 Y1 temp_XX2 temp_YY2 norm] = findHalo2(index,beta0,x,y,e1,e2);
        move= getDistance(final_X2,final_Y2,XXX2,YYY2);
        move2= getDistance(final_X2,final_Y2,XX2,YY2);
        if(move<temp_norm && move2<max_area)
            %temp_length = norm;
            temp_norm = move;
            temp_X1 = X1;
            temp_X2 = final_X2;
            temp_Y1 = Y1;
            temp_Y2 = final_Y2;

        end
    end
end

norm = temp_norm;
X1 = temp_X1;
Y1 = temp_Y1;
X2 = temp_X2;
Y2 = temp_Y2;

