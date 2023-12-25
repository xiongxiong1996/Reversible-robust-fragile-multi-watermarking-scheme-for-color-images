clc;clear;
% best_list=xlsread('best_list_lean.xls');
best_list=xlsread('image_25.xls');

for i =1:50
    best_list(i,5)=i;
end

a = best_list(:,5);
b = best_list(:,3);
c = best_list(:,4);


fig = figure;
left_color = [0 0 0];
right_color = [0 0 0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);

yyaxis left
p11=plot(a,c,'r-o','LineWidth',1);
xlabel('G');
ylabel('AvgNc');


yyaxis right
p12=plot(a,b,'b-.o','LineWidth',1);
title('');
ylabel('PSNR');

hold on;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% best_list=xlsread('best_list_Airplane.xls');
best_list=xlsread('image_26.xls');
b = best_list(:,3);
c = best_list(:,4);

yyaxis left
p21=plot(a,c,'r-x','LineWidth',1);
xlabel('G');
ylabel('AvgNc');


yyaxis right
p22=plot(a,b,'b-.x','LineWidth',1);
title('');
ylabel('PSNR');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% best_list=xlsread('best_list_Baboon.xls');
best_list=xlsread('image_27.xls');

b = best_list(:,3);
c = best_list(:,4);


yyaxis left
p31=plot(a,c,'r-+','LineWidth',1);
xlabel('G');
ylabel('AvgNc');


yyaxis right
p32=plot(a,b,'b-.+','LineWidth',1);
title('');
ylabel('PSNR');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% best_list=xlsread('best_list_Peppers.xls');
best_list=xlsread('image_28.xls');

b = best_list(:,3);
c = best_list(:,4);


yyaxis left
p41=plot(a,c,'r-*','LineWidth',1);
% xlabel('G');
xlabel('嵌入强度G');
% ylabel('AvgNc');
ylabel('平均NC值');

yyaxis right
p42=plot(a,b,'b-.*','LineWidth',1);
title('');
%ylabel('PSNR');
ylabel('PSNR值');



hg1=legend('莉娜 平均NC','狒狒 平均NC','辣椒 平均NC','飞机 平均NC');

set(hg1,'FontSize',12);


ah2 = axes('position',get(gca,'position'),'visible','off');
hg2=legend(ah2,[p12 p22 p32 p42],'莉娜 PSNR','狒狒 PSNR','辣椒 PSNR','飞机 PSNR');
set(hg2,'FontSize',12);

% legend('Lena','Airplane','Baboon','Peppers','Location','Best');
% legend('Lena','Baboon','Peppers','Airplane','Lena','Airplane','Baboon','Peppers','Location','Best');
