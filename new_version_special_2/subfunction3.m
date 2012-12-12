function  [C1 M1 C2 M2 C3 M3 E X1 Y1 X2 Y2 X3 Y3 norm]=subfunction3(step,index, x,y,e1,e2,x_start,y_start)

c1 = 1000;
m1 = 1;
c2 = 1000;
m2 = 1;
c3 = 1000;
m3 = 1;
e = 0;
c12 = 1e6;
c23 = 1e6;
c13 = 1e6;
c123 = 1e6;
r1 = 1;
r2 = 1;
r3 = 1;
r12 = 1;
r23 = 1;
r13 = 1;
r123 = 1;

E2 = 1;
temp_norm = 1e4;
temp_length = 1e5;

step = 500;
temp_norm = 1e4;
temp_length = 1e5;
max_area = step*1.41459*0.5;
temp_X1 =0;
temp_Y1 =0;
temp_X2 =0;
temp_Y2 =0;
temp_X3 =0;
temp_Y3 =0;
x_start(3) = 2100;
y_start(3) = 2100;
for XX2 = 0:step:4200
    for YY2 = 0:step:4200
        %first
        beta0 = [c1,m1,c2,m2,c3,m3,e,x_start(1),y_start(1),XX2,YY2,x_start(3),y_start(3),c12,c23,c13,c123,r1,r2,r3,r12,r23,r13,r123,E2];
        [C1 M1 C2 M2 C3 M3 E X1 Y1 final_X2 final_Y2 final_X3 final_Y3 norm] = findHalo3(index,beta0,x,y,e1,e2);
        %second
        beta0 = [c1,m1,c2,m2,c3,m3,e,x_X1,Y1,final_X2,final_Y2,final_X3,final_Y3,c12,c23,c13,c123,r1,r2,r3,r12,r23,r13,r123,E2];
        [C1 M1 C2 M2 C3 M3 E X1 Y1 X2 Y2 X3 Y3 norm] = findHalo3(index,beta0,x,y,e1,e2);
        move= getDistance(final_X2,final_Y2,X2,Y2);
        move2= getDistance(final_X3,final_Y3,X3,Y3);
        if((move+move2)<temp_norm)
            %temp_length = norm;
            temp_norm = move;
            temp_X1 = X1;
            temp_X2 = X2;
            temp_X3 = X3;
            temp_Y1 = Y1;
            temp_Y2 = Y2;
            temp_Y3 = Y3;
            
        end
    end
end


norm = temp_norm;
X1 = temp_X1;
Y1 = temp_Y1;
X2 = temp_X2;
Y2 = temp_Y2;
X3 = temp_X3;
Y3 = temp_Y3;


