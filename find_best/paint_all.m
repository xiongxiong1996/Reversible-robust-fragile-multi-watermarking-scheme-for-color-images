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
left_color = [.5 0 0];
right_color = [0 0 .5];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);

yyaxis left
plot(a,c,'k-o','LineWidth',1);
xlabel('G');
ylabel('AvgNc');


yyaxis right
plot(a,b,'k-.o','LineWidth',1);
title('');
ylabel('PSNR');

hold on;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% best_list=xlsread('best_list_Airplane.xls');
best_list=xlsread('image_26.xls');
b = best_list(:,3);
c = best_list(:,4);

yyaxis left
plot(a,c,'m-x','LineWidth',1);
xlabel('G');
ylabel('AvgNc');


yyaxis right
plot(a,b,'m-.x','LineWidth',1);
title('');
ylabel('PSNR');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% best_list=xlsread('best_list_Baboon.xls');
best_list=xlsread('image_27.xls');

b = best_list(:,3);
c = best_list(:,4);


yyaxis left
plot(a,c,'r-+','LineWidth',1);
xlabel('G');
ylabel('AvgNc');


yyaxis right
plot(a,b,'r-.+','LineWidth',1);
title('');
ylabel('PSNR');

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% best_list=xlsread('best_list_Peppers.xls');
best_list=xlsread('image_28.xls');

b = best_list(:,3);
c = best_list(:,4);


yyaxis left
plot(a,c,'c-*','LineWidth',1);
xlabel('G');
ylabel('AvgNc');


yyaxis right
plot(a,b,'c-.*','LineWidth',1);
title('');
ylabel('PSNR');


% legend('Lena','Airplane','Baboon','Peppers','Location','Best');
legend('Lena','Baboon','Peppers','Airplane','Location','Best');
