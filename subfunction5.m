function  [C M E temp_x temp_y temp_norm]=subfunction5(step,index,datafile,correct_X,correct_Y,x,y,e1,e2,x1,y1,C,M,E)
temp_norm = 1e4;

X = 0:step:4200;
Y = 0:step:4200;

tempC = zeros(length(X),length(Y));
tempM = zeros(length(X),length(Y));
tempE = zeros(length(X),length(Y));
norm = zeros(length(X),length(Y));
XX = zeros(length(X),length(Y));
YY = zeros(length(X),length(Y));
ii = 0;

for j = X
    ii = ii+1;
    jj=0;
    for k = Y
        jj=jj+1;
        index
        j
        k
        c = 1000;
        M = 1;
        e = C;
        tt = 1;
        eee  =0 ;
        x_start = j;
        y_start = k;
        [tempC(ii,jj) tempM(ii,jj) tempE(ii,jj) XX(ii,jj) YY(ii,jj) norm(ii,jj)] = findHalo5(index,[c,M,e,x_start,y_start,tt,eee],x,y,e1,e2,x1,y1,C,M,E);
        if(norm(ii,jj)<temp_norm)
            temp_norm = norm(ii,jj);
            temp_x = XX(ii,jj);
            temp_y = YY(ii,jj);
            C = tempC(ii,jj);
            E = tempE(ii,jj);
            M = tempM(ii,jj);
        end
        
    end
end

[Xgrid,Ygrid] = meshgrid(X,Y);
H = subplot(2,2,1);

[C,h] = contour(Xgrid,Ygrid,norm);
[XX2 YY2] = finmin(norm,1);
[XX3 YY3] = finmax(norm,1);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap cool
title('norm');
hold on;
plot(correct_X,correct_Y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
plot(XX(XX2,YY2),YY(XX2,YY2),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
plot(temp_x,temp_y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','blue','MarkerSize',10);
plot(XX(XX3,YY3),YY(XX3,YY3),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
axis([0 4200 0 4200]);


H = subplot(2,2,2);
[C,h] = contour(Xgrid,Ygrid,tempC);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap cool
title('tempC');
hold on;
plot(correct_X,correct_Y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
axis([0 4200 0 4200]);

H = subplot(2,2,3);
[C,h] = contour(Xgrid,Ygrid,tempM);
%[XX2 YY2] = finmin(tempM,2);
%[XX3 YY3] = finmax(tempM,2);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap cool
title('tempM');
hold on;
plot(correct_X,correct_Y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
%plot(XX(XX2,YY2),YY(XX2,YY2),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
%plot(XX(XX3,YY3),YY(XX3,YY3),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
axis([0 4200 0 4200]);

H = subplot(2,2,4);
[C,h] = contour(Xgrid,Ygrid,tempE);
%[XX2 YY2] = finmin(tempE,2);
%[XX3 YY3] = finmax(tempE,2);
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap cool
title('tempE');
hold on;
plot(correct_X,correct_Y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
%plot(XX(XX2,YY2),YY(XX2,YY2),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
%plot(XX(XX3,YY3),YY(XX3,YY3),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
axis([0 4200 0 4200]);
saveas(H, ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/figure/' datafile '/global_' num2str(index) '.png'],'png');
close;    