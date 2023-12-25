clc;clear;
best_list=xlsread('image_25.xls');
for i =1:50
    best_list(i,5)=i;
end

s=cell(50,1);
for i =1:50
    a1=best_list(i,1);
    a1=num2str(a1);
    a2=best_list(i,2);
    a2=num2str(a2);
    s{i}=['T=',a1,'  G=',a2];
end



a = best_list(:,5);
b = best_list(:,3);
c = best_list(:,4);


fig = figure;
left_color = [.5 0 0];
right_color = [0 0 .5];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);

yyaxis left
plot(a,c,'-o','MarkerFaceColor','w','LineWidth',2);
xlabel('T and G');
ylabel('AvgNc');
grid on;
set(gca,'xtick',a);
set(gca,'xticklabel',s);


yyaxis right
plot(a,b,'-.x','MarkerFaceColor','r','LineWidth',2);
title('');
ylabel('PSNR');

legend('AvgNC','PSNR','Location','Best');