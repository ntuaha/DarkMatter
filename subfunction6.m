function  [C M E temp_x temp_y temp_norm]=subfunction6(area,step,index,datafile,correct_X,correct_Y, x,y,e1,e2)
temp_norm = 1e4;



X = area(:,1);
Y = area(:,2);

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
        e = 0;

        x_start = j;
        y_start = k;
        [tempC(ii,jj) tempM(ii,jj) tempE(ii,jj) XX(ii,jj) YY(ii,jj) norm(ii,jj)] = findHalo4(index,[c,M,e,x_start,y_start],x,y,e1,e2);
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

% [Xgrid,Ygrid] = meshgrid(X,Y);
% H = subplot(2,2,1);
% 
% [C,h] = contour(Xgrid,Ygrid,norm);
% [XX2 YY2] = finmin(norm,2);
% [XX3 YY3] = finmax(norm,2);
% set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
% colormap cool
% title('norm');
% hold on;
% plot(correct_X,correct_Y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
% 
% plot(XX(XX2,YY2),YY(XX2,YY2),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
% plot(XX(XX3,XX3),YY(XX3,YY3),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
% axis([0 4200 0 4200]);
% 
% 
% H = subplot(2,2,2);
% [C,h] = contour(Xgrid,Ygrid,tempC);
% set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
% colormap cool
% title('tempC');
% hold on;
% plot(correct_X,correct_Y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
% axis([0 4200 0 4200]);
% 
% H = subplot(2,2,3);
% [C,h] = contour(Xgrid,Ygrid,tempM);
% [XX2 YY2] = finmin(tempM,2);
% [XX3 YY3] = finmax(tempM,2);
% set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
% colormap cool
% title('tempM');
% hold on;
% plot(correct_X,correct_Y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
% plot(XX(XX2,YY2),YY(XX2,YY2),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
% plot(XX(XX3,XX3),YY(XX3,YY3),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
% axis([0 4200 0 4200]);
% 
% H = subplot(2,2,4);
% [C,h] = contour(Xgrid,Ygrid,tempE);
% [XX2 YY2] = finmin(tempE,2);
% [XX3 YY3] = finmax(tempE,2);
% set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
% colormap cool
% title('tempE');
% hold on;
% plot(correct_X,correct_Y,'rs', 'MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10);
% plot(XX(XX2,YY2),YY(XX2,YY2),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10);
% plot(XX(XX3,XX3),YY(XX3,YY3),'rs', 'MarkerEdgeColor','k','MarkerFaceColor','y','MarkerSize',10);
% axis([0 4200 0 4200]);
% saveas(H, ['/Users/aha/Dropbox/Learning/2012_Kaggle/DarkSky/Matlab/figure/' datafile '/global_' num2str(index) '.png'],'png');
    