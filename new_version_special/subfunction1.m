function  [C1 M1 E X1 Y1 norm]=subfunction1(step,index, x,y,e1,e2,x_start,y_start)

c = 1000;
M = 1;
e = 0;
beta0 = [c,M,e,x_start(1),y_start(1)];
[C1 M1 E X1 Y1 norm] = findHalo1(index,beta0,x,y,e1,e2);

%length(e2)


%X = 0:step:4200
%Y = 0:step:4200

%tempC = zeros(length(X),length(Y));
%tempM = zeros(length(X),length(Y));
%tempE = zeros(length(X),length(Y));
%norm = zeros(length(X),length(Y));
%XX = zeros(length(X),length(Y));
%YY = zeros(length(X),length(Y));
%ii = 0;

%for j = X
%    ii = ii+1;
%    jj=0;
%    for k = Y
%        jj=jj+1;
%         index
%         j
%         k
%         c = 1000;
%         M = 1;
%         e = 0;
%
%         x_start = j;
%         y_start = k;
%         [tempC(ii,jj) tempM(ii,jj) tempE(ii,jj) XX(ii,jj) YY(ii,jj) norm(ii,jj)] = findHalo1(index,[c,M,e,x_start,y_start],x,y,e1,e2);
%         if(norm(ii,jj)<temp_norm)
%             temp_norm = norm(ii,jj);
%             temp_x = XX(ii,jj);
%             temp_y = YY(ii,jj);
%             C = tempC(ii,jj);
%             E = tempE(ii,jj);
%             M = tempM(ii,jj);
%         end
%
%     end
% end

